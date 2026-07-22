/// خدمة التخزين المحلي
library;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';

class StorageService {
  SharedPreferences? _prefs;
  late Box _settingsBox;
  late Box _cacheBox;
  late Box _sessionBox;

  /// تهيئة خدمة التخزين
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // تهيئة Hive
    await Hive.initFlutter();
    
    // فتح الصناديق
    _settingsBox = await Hive.openBox(AppConstants.boxSettings);
    _cacheBox = await Hive.openBox(AppConstants.boxCache);
    _sessionBox = await Hive.openBox(AppConstants.boxSession);
  }

  // ============================================
  // SharedPreferences Operations
  // ============================================

  /// حفظ قيمة نصية
  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// قراءة قيمة نصية
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// حفظ قيمة عددية
  Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// قراءة قيمة عددية
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// حفظ قيمة منطقية
  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// قراءة قيمة منطقية
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// حذف مفتاح
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// التحقق من وجود المفتاح
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  /// مسح جميع البيانات
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  // ============================================
  // Hive Settings Box Operations
  // ============================================

  /// حفظ إعداد في الصندوق
  Future<void> setSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }

  /// قراءة إعداد من الصندوق
  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue);
  }

  /// حذف إعداد
  Future<void> removeSetting(String key) async {
    await _settingsBox.delete(key);
  }

  /// الحصول على جميع الإعدادات
  Map<dynamic, dynamic> getAllSettings() {
    return _settingsBox.toMap();
  }

  // ============================================
  // Hive Cache Box Operations
  // ============================================

  /// تخزين مؤقت للبيانات
  Future<void> cacheData(String key, dynamic data) async {
    await _cacheBox.put(key, data);
  }

  /// استرجاع البيانات المخزنة مؤقتاً
  dynamic getCachedData(String key) {
    return _cacheBox.get(key);
  }

  /// التحقق من وجود بيانات مخزنة مؤقتاً
  bool hasCachedData(String key) {
    return _cacheBox.containsKey(key);
  }

  /// مسح البيانات المخزنة مؤقتاً
  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  /// حذف بيانات مخزنة مؤقتاً
  Future<void> removeCachedData(String key) async {
    await _cacheBox.delete(key);
  }

  // ============================================
  // Hive Session Box Operations
  // ============================================

  /// حفظ بيانات الجلسة
  Future<void> saveSessionData(String key, dynamic data) async {
    await _sessionBox.put(key, data);
  }

  /// استرجاع بيانات الجلسة
  dynamic getSessionData(String key) {
    return _sessionBox.get(key);
  }

  /// مسح بيانات الجلسة
  Future<void> clearSessionData() async {
    await _sessionBox.clear();
  }

  // ============================================
  // عمليات سريعة للإعدادات الشائعة
  // ============================================

  /// حفظ/قراءة وضع الظلام
  Future<void> setIsDarkMode(bool isDark) => setBool(AppConstants.keyIsDarkMode, isDark);
  bool? getIsDarkMode() => getBool(AppConstants.keyIsDarkMode);

  /// حفظ/قراءة كلمة المرور المشفرة
  Future<void> setPasswordHash(String hash) => setString(AppConstants.keyPasswordHash, hash);
  String? getPasswordHash() => getString(AppConstants.keyPasswordHash);

  /// حفظ/قراءة استخدام البصمة
  Future<void> setUseBiometrics(bool use) => setBool(AppConstants.keyUseBiometrics, use);
  bool? getUseBiometrics() => getBool(AppConstants.keyUseBiometrics);

  /// حفظ/قراءة رقم المنفذ
  Future<void> setServerPort(int port) => setInt(AppConstants.keyServerPort, port);
  int? getServerPort() => getInt(AppConstants.keyServerPort);

  /// حفظ/قراءة توكن الجلسة
  Future<void> setSessionToken(String token) => setString(AppConstants.keySessionToken, token);
  String? getSessionToken() => getString(AppConstants.keySessionToken);

  /// حفظ/قراءة وقت آخر نسخة احتياطية
  Future<void> setLastBackupTime(DateTime time) =>
      setString(AppConstants.keyLastBackupTime, time.toIso8601String());
  DateTime? getLastBackupTime() {
    final str = getString(AppConstants.keyLastBackupTime);
    if (str != null) return DateTime.tryParse(str);
    return null;
  }

  /// حفظ/قراءة تفعيل النسخ الاحتياطي التلقائي
  Future<void> setAutoBackupEnabled(bool enabled) =>
      setBool(AppConstants.keyAutoBackupEnabled, enabled);
  bool? getAutoBackupEnabled() => getBool(AppConstants.keyAutoBackupEnabled);

  /// التحقق مما إذا كانت هذه أول تشغيل
  bool isFirstLaunch() => getBool(AppConstants.keyIsFirstLaunch) ?? true;
  Future<void> setFirstLaunchCompleted() => setBool(AppConstants.keyIsFirstLaunch, false);

  /// إغلاق جميع الصناديق
  Future<void> dispose() async {
    await _settingsBox.close();
    await _cacheBox.close();
    await _sessionBox.close();
  }
}
