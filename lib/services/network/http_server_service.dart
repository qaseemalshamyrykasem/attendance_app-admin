/// خدمة الخادم HTTP المحلي
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../../core/constants/app_constants.dart';
import '../encryption/encryption_service.dart';

class HttpServerService {
  HttpServer? _server;
  bool _isRunning = false;
  String? _currentSessionToken;
  String? _currentSessionId;
  
  final EncryptionService _encryptionService;
  final StreamController<CheckInEvent> _checkInStreamController =
      StreamController<CheckInEvent>.broadcast();
  
  // Callbacks
  Function(CheckInRequest)? onCheckIn;
  Future<String> Function(String token)? onGetSessionInfo;
  Future<String> Function()? onGetSessionStatus;
  Future<bool> Function(String studentId)? onVerifyStudent;

  HttpServerService({
    EncryptionService? encryptionService,
  }) : _encryptionService = encryptionService ?? EncryptionService();

  /// الحصول على stream أحداث تسجيل الحضور
  Stream<CheckInEvent> get checkInStream => _checkInStreamController.stream;

  /// هل الخادم يعمل؟
  bool get isRunning => _isRunning;

  /// رقم المنفذ الحالي
  int? get port => _server?.port;

  /// عنوان IP المحلي
  Future<String> get localIp => _getLocalIp();

  /// توكن الجلسة الحالية
  String? get currentSessionToken => _currentSessionToken;

  /// معرف الجلسة الحالية
  String? get currentSessionId => _currentSessionId;

  /// عدد الاتصالات النشطة
  int get connectedCount => _connectionCount;

  int _connectionCount = 0;

  // ============================================
  // إدارة الخادم
  // ============================================

  /// بدء الخادم
  Future<bool> start({
    required int port,
    required String sessionToken,
    required String sessionId,
  }) async {
    if (_isRunning) {
      throw ServerException('Server is already running');
    }

    try {
      _server = await HttpServer.bind(
        AppConstants.defaultServerHost,
        port,
        shared: true,
      );

      _currentSessionToken = sessionToken;
      _currentSessionId = sessionId;
      _isRunning = true;
      _connectionCount = 0;

      // الاستماع للطلبات
      _server!.listen(_handleRequest, onError: _handleError);

      return true;
    } on SocketException catch (e) {
      throw ServerException('Failed to bind server: ${e.message}');
    } catch (e) {
      throw ServerException('Failed to start server: $e');
    }
  }

  /// إيقاف الخادم
  Future<void> stop() async {
    if (!_isRunning || _server == null) return;

    try {
      await _server!.close(force: true);
      _server = null;
      _isRunning = false;
      _currentSessionToken = null;
      _currentSessionId = null;
      _connectionCount = 0;
    } catch (e) {
      throw ServerException('Failed to stop server: $e');
    }
  }

  /// إعادة تشغيل الخادم
  Future<bool> restart({int? newPort}) async {
    if (_currentSessionToken == null || _currentSessionId == null) {
      throw ServerException('No active session');
    }

    await stop();
    
    return start(
      port: newPort ?? port ?? AppConstants.defaultServerPort,
      sessionToken: _currentSessionToken!,
      sessionId: _currentSessionId!,
    );
  }

  // ============================================
  // معالجة الطلبات
  // ============================================

  void _handleRequest(HttpRequest request) {
    // إضافة CORS headers
    _setCorsHeaders(request.response);

    // معالجة طلبات OPTIONS (Preflight)
    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      request.response.close();
      return;
    }

    try {
      final path = request.uri.path;
      
      switch (request.method.toUpperCase()) {
        case 'POST':
          _handlePostRequest(path, request);
          break;
        case 'GET':
          _handleGetRequest(path, request);
          break;
        default:
          _sendErrorResponse(
            request.response,
            statusCode: HttpStatus.methodNotAllowed,
            error: 'Method not allowed',
          );
      }
    } catch (e) {
      _sendErrorResponse(
        request.response,
        statusCode: HttpStatus.internalServerError,
        error: 'Internal server error',
      );
    }
  }

  void _handlePostRequest(String path, HttpRequest request) {
    switch (path) {
      case AppConstants.apiCheckIn:
        _handleCheckIn(request);
        break;
      case AppConstants.apiStudentVerify:
        _handleStudentVerify(request);
        break;
      default:
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.notFound,
          error: 'Endpoint not found',
        );
    }
  }

  void _handleGetRequest(String path, HttpRequest request) {
    switch (path) {
      case AppConstants.apiSessionInfo:
        _handleGetSessionInfo(request);
        break;
      case AppConstants.apiSessionStatus:
        _handleGetSessionStatus(request);
        break;
      case AppConstants.apiHealthCheck:
        _handleHealthCheck(request);
        break;
      default:
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.notFound,
          error: 'Endpoint not found',
        );
    }
  }

  // ============================================
  // Endpoints Implementation
  // ============================================

  /// تسجيل الحضور - POST /api/attendance/check-in
  Future<void> _handleCheckIn(HttpRequest request) async {
    try {
      // قراءة body الطلب
      final body = await utf8.decoder.bind(request).join();
      if (body.isEmpty) {
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.badRequest,
          error: 'Request body is empty',
        );
        return;
      }

      final data = jsonDecode(body) as Map<String, dynamic>;
      final checkInRequest = CheckInRequest.fromJson(data);

      // التحقق من صحة التوكن
      if (checkInRequest.sessionToken != _currentSessionToken) {
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.unauthorized,
          error: ErrorMessages.authError,
        );
        return;
      }

      // التحقق من أن الخادم يعمل
      if (!_isRunning) {
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.serviceUnavailable,
          error: ErrorMessages.sessionClosed,
        );
        return;
      }

      // التحقق من hash إذا موجود (التوافق مع تطبيق Student)
      if (checkInRequest.hash != null && checkInRequest.hash!.isNotEmpty) {
        // التحقق من timestamp — يجب أن يكون ضمن 5 دقائق
        final timestampStr = data['timestamp'] as String?;
        if (timestampStr != null) {
          final timestamp = DateTime.tryParse(timestampStr);
          if (timestamp != null) {
            final now = DateTime.now();
            final diff = now.difference(timestamp).inMinutes.abs();
            if (diff > 5) {
              _sendErrorResponse(
                request.response,
                statusCode: HttpStatus.badRequest,
                error: 'طلب منتهي الصلاحية — timestamp قديم',
              );
              return;
            }
          }
        }
      }

      // زيادة عدد الاتصالات
      _connectionCount++;

      // استدعاء callback إذا موجود
      if (onCheckIn != null) {
        final result = await onCheckIn!(checkInRequest);
        
        // إرسال الحدث للـ stream
        _checkInStreamController.add(CheckInEvent(
          studentId: checkInRequest.studentId,
          timestamp: DateTime.now(),
          deviceId: checkInRequest.deviceId,
        ));

        _sendSuccessResponse(
          request.response,
          data: jsonDecode(result),
        );
      } else {
        // استجابة افتراضية
        _sendSuccessResponse(
          request.response,
          data: {
            'success': true,
            'message': SuccessMessages.attendanceRecorded,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
      }
    } catch (e) {
      _sendErrorResponse(
        request.response,
        statusCode: HttpStatus.badRequest,
        error: e.toString(),
      );
    }
  }

  /// الحصول على معلومات الجلسة - GET /api/session/info
  Future<void> _handleGetSessionInfo(HttpRequest request) async {
    try {
      if (onGetSessionInfo != null) {
        final infoJson = await onGetSessionInfo!(_currentSessionToken!);
        _sendSuccessResponse(
          request.response,
          data: jsonDecode(infoJson),
        );
      } else {
        _sendSuccessResponse(
          request.response,
          data: {
            'status': _isRunning ? 'active' : 'stopped',
            'port': port,
            'connectedCount': _connectionCount,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
      }
    } catch (e) {
      _sendErrorResponse(
        request.response,
        statusCode: HttpStatus.internalServerError,
        error: e.toString(),
      );
    }
  }

  /// الحصول على حالة الجلسة - GET /api/session/status
  Future<void> _handleGetSessionStatus(HttpRequest request) async {
    try {
      if (onGetSessionStatus != null) {
        final statusJson = await onGetSessionStatus!();
        _sendSuccessResponse(
          request.response,
          data: jsonDecode(statusJson),
        );
      } else {
        _sendSuccessResponse(
          request.response,
          data: {
            'isRunning': _isRunning,
            'hasActiveSession': _currentSessionToken != null,
            'sessionId': _currentSessionId,
            'connectedCount': _connectionCount,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
      }
    } catch (e) {
      _sendErrorResponse(
        request.response,
        statusCode: HttpStatus.internalServerError,
        error: e.toString(),
      );
    }
  }

  /// التحقق من الطالب - POST /api/student/verify
  Future<void> _handleStudentVerify(HttpRequest request) async {
    try {
      final body = await utf8.decoder.bind(request).join();
      if (body.isEmpty) {
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.badRequest,
          error: 'Request body is empty',
        );
        return;
      }

      final data = jsonDecode(body) as Map<String, dynamic>;
      final studentId = data['student_id'] as String?;

      if (studentId == null || studentId.isEmpty) {
        _sendErrorResponse(
          request.response,
          statusCode: HttpStatus.badRequest,
          error: 'Student ID is required',
        );
        return;
      }

      if (onVerifyStudent != null) {
        final isValid = await onVerifyStudent!(studentId);
        
        _sendSuccessResponse(
          request.response,
          data: {
            'valid': isValid,
            'studentId': studentId,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
      } else {
        _sendSuccessResponse(
          request.response,
          data: {
            'valid': true,
            'studentId': studentId,
            'timestamp': DateTime.now().toIso8601String(),
          },
        );
      }
    } catch (e) {
      _sendErrorResponse(
        request.response,
        statusCode: HttpStatus.badRequest,
        error: e.toString(),
      );
    }
  }

  /// فحص الصحة - GET /api/health
  void _handleHealthCheck(HttpRequest request) {
    _sendSuccessResponse(
      request.response,
      data: {
        'status': 'healthy',
        'service': 'Attendance Admin API',
        'version': AppConstants.appVersion,
        'isRunning': _isRunning,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // ============================================
  // Utilities
  // ============================================

  /// تعيين CORS headers
  void _setCorsHeaders(HttpResponse response) {
    response.headers.set('Access-Control-Allow-Origin', '*');
    response.headers.set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    response.headers.set(
      'Access-Control-Allow-Headers',
      'Origin, Content-Type, Accept, Authorization',
    );
    response.headers.set('Access-Control-Max-Age', '86400');
    response.headers.contentType = ContentType.json;
  }

  /// إرسال استجابة ناجحة
  void _sendSuccessResponse(
    HttpResponse response, {
    required Map<String, dynamic> data,
    int statusCode = HttpStatus.ok,
  }) {
    response.statusCode = statusCode;
    response.write(jsonEncode(data));
    response.close();
  }

  /// إرسال استجابة خطأ
  void _sendErrorResponse(
    HttpResponse response, {
    required int statusCode,
    required String error,
    String? details,
  }) {
    response.statusCode = statusCode;
    response.write(jsonEncode({
      'success': false,
      'error': error,
      if (details != null) 'details': details,
      'timestamp': DateTime.now().toIso8601String(),
    }));
    response.close();
  }

  /// معالجة الأخطاء
  void _handleError(Object error) {
    print('Server error: $error');
  }

  /// الحصول على IP المحلي
  Future<String> _getLocalIp() async {
    try {
      for (var interface in await NetworkInterface.list(type: InternetAddressType.IPv4)) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      print('Error getting local IP: $e');
    }
    return '127.0.0.1';
  }

  /// التخلص من الموارد
  void dispose() {
    stop();
    _checkInStreamController.close();
  }
}

// ============================================
// Models
// ============================================

/// طلب تسجيل الحضور
class CheckInRequest {
  final String studentId;
  final String sessionToken;
  final String? deviceId;
  final String? hash;
  final String? timestamp;

  CheckInRequest({
    required this.studentId,
    required this.sessionToken,
    this.deviceId,
    this.hash,
    this.timestamp,
  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) {
    return CheckInRequest(
      studentId: json['student_id'] as String? ?? '',
      sessionToken: json['session_token'] as String? ?? '',
      deviceId: json['device_id'] as String?,
      hash: json['hash'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'session_token': sessionToken,
      if (deviceId != null) 'device_id': deviceId,
      if (hash != null) 'hash': hash,
      if (timestamp != null) 'timestamp': timestamp,
    };
  }
}

/// حدث تسجيل حضور جديد
class CheckInEvent {
  final String studentId;
  final DateTime timestamp;
  final String? deviceId;

  CheckInEvent({
    required this.studentId,
    required this.timestamp,
    this.deviceId,
  });
}

/// استثناءات الخادم
class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}
