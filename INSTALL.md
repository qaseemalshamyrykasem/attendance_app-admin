# 📦 دليل التثبيت - نظام الحضور الذكي

<p align="center">
  <strong>تعليمات التثبيت التفصيلية لتطبيق Attendance Admin</strong>
</p>

---

## 📋 جدول المحتويات

- [المتطلبات الأساسية](#-المتطلبات-الأساسية)
- [إعداد بيئة التطوير](#-إعداد-بيئة-التطوير)
- [استنساخ المشروع](#-استنساخ-المشروع)
- [تثبيت التبعيات](#-تثبيت-التبعيات)
- [تشغيل Code Generation](#-تشغيل-code-generation)
- [تشغيل التطبيق](#-تشغيل-التطبيق)
- [بناء APK للإنتاج](#-بناء-apk-للإنتاج)
- [حل المشاكل الشائعة](#-حل-المشاكل-الشائعة)

---

## ⚡ المتطلبات الأساسية

### 1. Flutter SDK

```bash
# التحقق من تثبيت Flutter
flutter --version

# يجب أن يكون الإصدار:
# Flutter 3.x أو أحدث
# Dart 3.x أو أحدث
```

**لتثبيت Flutter:**

```bash
# على Linux/macOS
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# على Windows - حمل من:
# https://docs.flutter.dev/get-started/install/windows
```

### 2. Android Studio (أو VS Code)

**Android Studio:**
1. حمّل من: https://developer.android.com/studio
2. ثبّت Flutter و Dart Plugins
3. فعّل Android SDK Tools

**VS Code:**
1. ثبّت VS Code
2. ثبّت امتدادات:
   - Flutter
   - Dart

### 3. Android SDK

```bash
# التحقق من Android SDK
flutter doctor --android-licenses

# قبول جميع التراخيص
flutter doctor --android-licenses
```

### 4. أدوات إضافية

| الأداة | الغرض | التثبيت |
|--------|-------|---------|
| **Git** | التحكم بالإصدار | `sudo apt install git` |
| **Java JDK 11+** | بناء Android | `sudo apt install openjdk-11-jdk` |
| **Chrome** | تشغيل Web version | تحميل من Google |

---

## 🔧 إعداد بيئة التطوير

### الخطوة 1: فحص البيئة

```bash
# تشغيل الفحص الشامل
flutter doctor

# النتيجة المتوقعة:
# ✗ No issues found!
# أو تحذيرات يمكن تجاهلها في البداية
```

### الخطوة 2: إعداد الجهاز/المحاكي

**خيار A: جهاز حقيقي (موصى به)**

1. فعّل **USB Debugging** في الهاتف:
   - اذهب إلى **Settings > About Phone**
   - اضغط على **Build Number** 7 مرات
   - عد إلى **Settings > Developer Options**
   - فعّل **USB Debugging**

2. وصّل الهاتف بالكمبيوتر:

```bash
# التحقق من اتصال الجهاز
flutter devices
```

**خيار B: محاكي Android**

```bash
# إنشاء محاكي عبر Android Studio
# AVD Manager > Create Device > Pixel 4 > API 31+

# أو سطر الأوامر
avdmanager create avd -n pixel_4 -k "system-images;android-31;google_apis;x86_64"
emulator -avd pixel_4
```

---

## 📥 استنساخ المشروع

### من GitHub

```bash
# استنساخ المشروع
git clone https://github.com/your-repo/attendance_admin.git

# الدخول للمجلد
cd attendance_admin

# عرض الفروع المتاحة
git branch -a

# الانتقال لفرع معين (اختياري)
git checkout develop
```

### من ZIP

1. حمّل الملف: `attendance_admin-main.zip`
2. فك الضغط:
```bash
unzip attendance_admin-main.zip
cd attendance_admin-main
```

---

## 📦 تثبيت التبعيات

### flutter pub get

```bash
# تثبيت جميع الحزم المذكورة في pubspec.yaml
flutter pub get
```

**ما يحدث عند التنفيذ:**
- قراءة ملف `pubspec.yaml`
- تنزيل الحزم من `pub.dev`
- إنشاء ملف `.dart_tool/package_config.json`
- حل التبعيات المتعارضة

### هيكل التبعيات الرئيسية

```
dependencies:
├── flutter_riverpod          # إدارة الحالة
├── go_router                # التنقل
├── drift                    # قاعدة البيانات
├── shelf                    # خادم HTTP
├── freezed_annotation       # Models غير قابلة للتغيير
├── hive                     # تخزين محلي
├── qr_flutter               # رموز QR
└── excel / pdf              # تصدير التقارير

dev_dependencies:
├── build_runner             # Code Generation
├── freezed                  # Freezed Generator
├── json_serializable        # JSON Serialization
├── drift_dev                # Drift Code Gen
└── riverpod_generator       # Riverpod Code Gen
```

---

## ⚙️ تشغيل Code Generation

### Build Runner

يستخدم المشروع **Code Generation** لتوليد كود تلقائي:

| المكتبة | الملفات المُولَّدة |
|---------|-------------------|
| **Drift** | `local_database.g.dart` |
| **Freezed** | `*.freezed.dart`, `*.g.dart` |
| **Json Serializable** | `*.g.dart` |
| **Riverpod** | `*.g.dart` |
| **Hive** | `*.g.dart` |

### الأمر الأساسي

```bash
# توليد الكود (مع حذف الملفات المتعارضة)
flutter pub run build_runner build --delete-conflicting-outputs
```

### خيارات إضافية

```bash
# توليد ومتابعة التغييرات (للتطوير)
flutter pub run build_runner watch --delete-conflicting-outputs

# تنظيف قبل التوليد
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### وقت التوليد المتوقع

| العملية | الوقت التقريبي |
|---------|---------------|
| **أول مرة** | 3-5 دقائق |
| **تحديثات لاحقة** | 30-60 ثانية |

> **💡 نصيحة:** استخدم `watch` أثناء التطوير لتوليد تلقائي عند حفظ الملفات.

---

## 🚀 تشغيل التطبيق

### وضع التصحيح (Debug)

```bash
# تشغيل على جميع الأجهزة المتاحة
flutter run

# تشغيل على جهاز محدد
flutter run -d <device-id>

# تشغيل على Chrome (Web)
flutter run -d chrome

# تشغيل على محاكي محدد
flutter run -d emulator-5554
```

### خيارات التشغيل المتقدمة

```bash
# تشغيل في وضع Release (أسرع)
flutter run --release

# تشغيل مع Profile (لقياس الأداء)
flutter run --profile

# تشغيل مع تفاصيل أكثر
flutter run -v

# تشغيل مع اختيار Flavor (إن وجد)
flutter run --flavor dev
```

### أوامر مفيدة أثناء التشغيل

| الاختصار | الوظيفة |
|----------|---------|
| `r` | إعادة تشغيل الساخن (Hot Restart) |
| `R` | إعادة تشغيل كاملة (Full Restart) |
| `q` | إنهاء التطبيق |
| `p` | تبديل إطار الشاشة |
| `o` | تبديل بين Android/iOS |
| `h` | عرض جميع المساعدات |

---

## 🏗️ بناء APK للإنتاج

### APK للتحميل المباشر

```bash
# APK Debug (للاختبار فقط، حجم كبير)
flutter build apk --debug

# APK Release (للإصدار النهائي، مضغوط)
flutter build apk --release

# APK بـ architecture محددة (أصغر حجماً)
flutter build apk --release --target-platform android-arm64
```

### App Bundle (Google Play)

```bash
# App Bundle للنشر على Google Play
flutter build appbundle --release

# الملف الناتج: build/app/outputs/bundle/release/app-release.aab
```

### توقيع APK (Signing)

**إنشاء Keystore:**

```bash
keytool -genkey -v -keystore ~/keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias attendance_admin
```

**إعداد التوقيع في android/app/build.gradle:**

```gradle
android {
    signingConfigs {
        release {
            keyAlias 'attendance_admin'
            keyPassword 'your_password'
            storeFile file('/path/to/keystore.jks')
            storePassword 'your_password'
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### مواقع الملفات المُنشأة

| نوع البناء | موقع الملف |
|------------|-----------|
| **Debug APK** | `build/app/outputs/flutter-apk/app-debug.apk` |
| **Release APK** | `build/app/outputs/flutter-apk/app-release.apk` |
| **App Bundle** | `build/app/outputs/bundle/release/app-release.aab` |

---

## 🐛 حل المشاكل الشائعة

### مشاكل Flutter Doctor

#### ❌ "Android license not accepted"

```bash
# الحل: قبول التراخيص
flutter doctor --android-licenses
echo "y" | flutter doctor --android-licenses
```

#### ❌ "Xcode not installed" (macOS)

```bash
# الحل: تثبيت Xcode من App Store
# ثم:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
```

#### ❌ "Chrome not installed"

```bash
# الحل: تثبيت Chrome أو استخدام متصفح آخر
# Ubuntu:
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

---

### مشاكل Dependencies

#### ❌ "pub get failed" / Network Error

```bash
# الحل 1: استخدام Proxy (إن وجد)
export HTTP_PROXY=http://your-proxy:port
export HTTPS_PROXY=http://your-proxy:port
flutter pub get

# الحل 2: استخدام Mirror الصيني
PUB_HOSTED_URL=https://pub.flutter-io.cn
FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get

# الحل 3: مسح الكاش
flutter clean
flutter pub get
```

#### ❌ "Version solving failed"

```bash
# الحل: ترقية الحزم
flutter pub upgrade

# أو ترقية حزمة محددة
flutter pub upgrade package_name
```

---

### مشاكل Build Runner

#### ❌ "Could not find generated file"

```bash
# الحل: إعادة توليد الكود
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

#### ❌ "Generator is already running"

```bash
# الحل: قتل العمليات وإعادة المحاولة
pkill -f build_runner
flutter pub run build_runner build
```

#### ❌ "Out of memory"

```bash
# الحل: زيادة ذاكرة JVM
export VM_OPTIONS="-Xmx4G"
flutter pub run build_runner build
```

---

### مشاكل البناء

#### ❌ "Failed to shrink resources"

```bash
# الحل: تعطيل shrinking مؤقتاً
# في android/app/build.gradle:
buildTypes {
    release {
        shrinkResources false
        minifyEnabled false
    }
}
```

#### ❌ "License for package Android SDK not accepted"

```bash
# الحل: قبول التراخيص يدوياً
yes | sdkmanager --licenses
```

#### ❌ "Gradle build failed"

```bash
# الحل 1: تنظيف Gradle
cd android
./gradlew clean
cd ..

# الحل 2: إعادة بناء
flutter clean
flutter pub get
flutter build apk --release
```

---

### مشاكل التشغيل

#### ❌ "No connected devices"

```bash
# التحقق من الأجهزة
flutter devices

# بدء المحاكي
emulator -list-avds
emulator -avd <avd-name>
```

#### ❌ "Waiting for another flutter command"

```bash
# حذف ملف القفل
rm ~/.flutter_tool_state
rm flutter/.dart_tool/flutter_build_daemon.lock
```

---

## ✅ قائمة التحقق قبل البناء

قبل بناء نسخة الإنتاج، تأكد من:

- [ ] `flutter doctor` بدون أخطاء حرجة
- [ ] `flutter pub get` نجاح كامل
- [ ] `build runner build` بدون أخطاء
- [ ] اختبار التطبيق على جهاز حقيقي
- [ ] تغيير اسم الحزمة (`com.attendance.admin`)
- [ ] تحديث رقم الإصدار في `pubspec.yaml`
- [ ] إعداد Keystore للتوقيع
- [ ] مراجعة أذونات Android في `AndroidManifest.xml`
- [ ] اختبار جميع الميزات الرئيسية
- [ ] تصغير حجم الـ APK قدر الإمكان

---

## 📞 الحصول على المساعدة

إذا واجهت مشكلة غير مدرجة هنا:

1. ابحث في [Flutter Documentation](https://docs.flutter.dev/)
2. ابحث في [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
3. افتح [Issue على GitHub](https://github.com/your-repo/attendance_admin/issues)

---

<p align="center">
  <strong>🎉 تم إعداد دليل التثبيت بنجاح!</strong>
</p>
