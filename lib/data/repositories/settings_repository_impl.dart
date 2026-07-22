/// تنفيذ مستودع الإعدادات - يربط قاعدة البيانات والتخزين بالطبقة الدومين
library;

import '../../domain/repositories/repositories.dart';
import '../../services/database/local_database.dart';
import '../../services/storage/storage_service.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final AppDatabase _database;
  final StorageService _storageService;

  SettingsRepositoryImpl(this._database, this._storageService);

  @override
  Future<String?> getSetting(String key) async {
    // محاولة القراءة من قاعدة البيانات أولاً
    final dbSetting = await _database.getSetting(key);
    if (dbSetting != null) {
      return dbSetting.value;
    }
    // محاولة القراءة من SharedPreferences
    return _storageService.getString(key);
  }

  @override
  Future<void> setSetting(String key, String value) async {
    // حفظ في قاعدة البيانات
    await _database.setSetting(key, value);
    // حفظ في SharedPreferences أيضاً للوصول السريع
    await _storageService.setString(key, value);
  }

  @override
  Future<void> deleteSetting(String key) async {
    await _database.deleteSetting(key);
    await _storageService.remove(key);
  }

  @override
  Future<Map<String, String>> getAllSettings() async {
    final allSettings = _storageService.getAllSettings();
    return allSettings.map((key, value) => MapEntry(key.toString(), value.toString()));
  }
}
