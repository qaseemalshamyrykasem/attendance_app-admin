/// خدمة التشفير — الإصدار المحسن
/// تم إصلاح: IV عشوائي لكل عملية، SecureRandom حقيقي للـ tokens، إزالة duplicate decryptJson
library;

import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  // المفتاح الافتراضي — في الإنتاج يجب تخزينه في secure storage
  static const String _defaultKey = 'AttendanceAdmin2024SecureKey!';

  late final encrypt.Key _key;
  final encrypt.Encrypter _encrypter;

  EncryptionService({
    String? key,
  })  : _key = encrypt.Key.fromUtf8(key ?? _defaultKey),
        _encrypter = encrypt.Encrypter(
          encrypt.AES(
            encrypt.Key.fromUtf8(key ?? _defaultKey),
            mode: encrypt.AESMode.cbc,
          ),
        );

  // ============================================
  // IV Generation — عشوائي لكل عملية تشفير
  // ============================================

  /// توليد IV عشوائي لكل عملية تشفير
  encrypt.IV _generateRandomIv() {
    final random = encrypt.SecureRandom(16);
    return encrypt.IV(random.bytes);
  }

  // ============================================
  // Hash Functions
  // ============================================

  /// إنشاء SHA256 Hash
  String computeSha256(String input) {
    final bytes = utf8.encode(input);
    final hash = crypto.sha256.convert(bytes);
    return hash.toString();
  }

  /// إنشاء MD5 Hash (للاستخدامات البسيطة فقط)
  String computeMd5(String input) {
    final bytes = utf8.encode(input);
    final hash = crypto.md5.convert(bytes);
    return hash.toString();
  }

  /// إنشاء Hash للتحقق من سلامة البيانات
  String generateDataHash(Map<String, dynamic> data) {
    final sortedKeys = data.keys.toList()..sort();
    final concatenated = sortedKeys.map((k) => '$k:${data[k]}').join('|');
    return computeSha256(concatenated);
  }

  /// إنشاء Hash لتسجيل الحضور
  String generateAttendanceHash({
    required String studentId,
    required String sessionId,
    required DateTime timestamp,
    required String deviceId,
  }) {
    final data = '$studentId|$sessionId|${timestamp.millisecondsSinceEpoch}|$deviceId';
    return computeSha256(data);
  }

  // ============================================
  // Encryption/Decryption — IV عشوائي لكل عملية
  // ============================================

  /// تشفير نص — كل عملية تشفير تستخدم IV عشوائي جديد
  /// النتيجة: base64(IV):base64(encrypted) — يمكن فك التشفير باستخراج IV
  String encryptText(String plainText) {
    try {
      final iv = _generateRandomIv();
      final encrypted = _encrypter.encrypt(plainText, iv: iv);
      return '${iv.base64}:${encrypted.base64}';
    } catch (e) {
      throw EncryptionException('Encryption failed: $e');
    }
  }

  /// فك تشفير نص — يستخرج IV من البداية ثم يفك التشفير
  String decryptText(String encryptedText) {
    try {
      final parts = encryptedText.split(':');
      if (parts.length != 2) {
        // تنسيق قديم (IV ثابت) — fallback
        final decrypted = _encrypter.decrypt64(encryptedText, iv: encrypt.IV.fromUtf8('1234567890123456'));
        return decrypted;
      }
      final iv = encrypt.IV.fromBase64(parts[0]);
      final decrypted = _encrypter.decrypt64(parts[1], iv: iv);
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
  // Token Generation — SecureRandom حقيقي
  // ============================================

  /// إنشاء Token آمن — استخدام SecureRandom حقيقي
  String generateToken({int length = 32}) {
    final random = encrypt.SecureRandom(length);
    return base64Url.encode(random.bytes).substring(0, length);
  }

  /// إنشاء Session Token فريد
  String generateSessionToken({
    required String courseId,
    required String sectionId,
    required DateTime date,
  }) {
    final data = '$courseId|$sectionId|${date.millisecondsSinceEpoch}';
    final hash = computeSha256(data);
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
  /// Salt ثابت للمشروع حالياً — TODO: في الإنتاج، توليد salt عشوائي لكل مستخدم
  String hashPassword(String password) {
    const salt = 'AttendanceAdminSalt2024';
    final saltedPassword = password + salt;
    return computeSha256(saltedPassword);
  }

  /// التحقق من كلمة المرور
  bool verifyPassword(String password, String hashedPassword) {
    return hashPassword(password) == hashedPassword;
  }

  // ============================================
  // Device ID
  // ============================================

  /// إنشاء Device ID فريد — استخدام SecureRandom
  String generateDeviceId() {
    final random = encrypt.SecureRandom(8);
    final timestamp = DateTime.now().millisecondsSinceEpoch.toRadixString(16);
    return 'device_${timestamp}_${base64Url.encode(random.bytes)}';
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
