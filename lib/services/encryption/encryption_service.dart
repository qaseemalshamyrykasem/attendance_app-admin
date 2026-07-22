/// خدمة التشفير
library;

import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  static const String _defaultKey = 'AttendanceAdmin2024SecureKey!';
  static const String _defaultIv = '1234567890123456';

  late final encrypt.Key _key;
  late final encrypt.IV _iv;
  final encrypt.Encrypter _encrypter;

  EncryptionService({
    String? key,
    String? iv,
  })  : _key = encrypt.Key.fromUtf8(key ?? _defaultKey),
        _iv = encrypt.IV.fromUtf8(iv ?? _defaultIv),
        _encrypter = encrypt.Encrypter(
          encrypt.AES(
            encrypt.Key.fromUtf8(key ?? _defaultKey),
            mode: encrypt.AESMode.cbc,
          ),
        );

  // ============================================
  // Hash Functions
  // ============================================

  /// إنشاء SHA256 Hash
  String sha256(String input) {
    final bytes = utf8.encode(input);
    final hash = crypto.sha256.convert(bytes);
    return hash.toString();
  }

  /// إنشاء MD5 Hash (للاستخدامات البسيطة فقط)
  String md5(String input) {
    final bytes = utf8.encode(input);
    final hash = crypto.md5.convert(bytes);
    return hash.toString();
  }

  /// إنشاء Hash للتحقق من سلامة البيانات
  String generateDataHash(Map<String, dynamic> data) {
    final sortedKeys = data.keys.toList()..sort();
    final concatenated = sortedKeys.map((k) => '$k:${data[k]}').join('|');
    return sha256(concatenated);
  }

  /// إنشاء Hash لتسجيل الحضور
  String generateAttendanceHash({
    required String studentId,
    required String sessionId,
    required DateTime timestamp,
    required String deviceId,
  }) {
    final data = '$studentId|$sessionId|${timestamp.millisecondsSinceEpoch}|$deviceId';
    return sha256(data);
  }

  // ============================================
  // Encryption/Decryption
  // ============================================

  /// تشفير نص
  String encryptText(String plainText) {
    try {
      final encrypted = _encrypter.encrypt(plainText, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      throw EncryptionException('Encryption failed: $e');
    }
  }

  /// فك تشفير نص
  String decryptText(String encryptedText) {
    try {
      final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
      return decrypted;
    } catch (e) {
      throw DecryptionException('Decryption failed: $e');
    }
  }

  /// تشفير JSON
  String encryptJson(Map<String, dynamic> json) {
    final jsonString = jsonEncode(json);
    return encryptText(jsonString);
  }

  /// فك تشفير JSON
  Map<String, dynamic> decryptJson(String encryptedJson) {
    final jsonString = decryptText(encryptedJson);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  // ============================================
  // Token Generation
  // ============================================

  /// إنشاء Token آمن
  String generateToken({int length = 32}) {
    final bytes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      bytes[i] = DateTime.now().microsecondsSinceEpoch % 256 + i;
    }
    final random = encrypt.SecureRandom(length);
    return base64Url.encode(bytes).substring(0, length);
  }

  /// إنشاء Session Token فريد
  String generateSessionToken({
    required String courseId,
    required String sectionId,
    required DateTime date,
  }) {
    final data = '$courseId|$sectionId|${date.millisecondsSinceEpoch}';
    final hash = sha256(data);
    return '${hash.substring(0, 16)}_${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}';
  }

  /// إنشاء QR Data
  String generateQrData({
    required String sessionToken,
    required String ip,
    required int port,
  }) {
    final data = {
      'token': sessionToken,
      'ip': ip,
      'port': port.toString(),
      'type': 'attendance_session',
      'ts': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    return base64Url.encode(utf8.encode(jsonEncode(data)));
  }

  /// فك تشفير QR Data
  Map<String, dynamic>? parseQrData(String qrData) {
    try {
      final decoded = utf8.decode(base64Url.decode(qrData));
      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // ============================================
  // Password Utilities
  // ============================================

  /// تشفير كلمة المرور (للتخزين)
  String hashPassword(String password) {
    // Salt ثابت للمشروع (في الإنتاج يجب استخدام salt عشوائي لكل مستخدم)
    const salt = 'AttendanceAdminSalt2024';
    final saltedPassword = password + salt;
    return sha256(saltedPassword);
  }

  /// التحقق من كلمة المرور
  bool verifyPassword(String password, String hashedPassword) {
    return hashPassword(password) == hashedPassword;
  }

  // ============================================
  // Device ID
  // ============================================

  /// إنشاء Device ID فريد
  String generateDeviceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toRadixString(16);
    final random = DateTime.now().microsecond.toRadixString(16);
    return 'device_${timestamp}_$random';
  }
}

/// استثناءات التشفير
class EncryptionException implements Exception {
  final String message;
  const EncryptionException(this.message);
  
  @override
  String toString() => 'EncryptionException: $message';
}

class DecryptionException implements Exception {
  final String message;
  const DecryptionException(this.message);
  
  @override
  String toString() => 'DecryptionException: $message';
}
