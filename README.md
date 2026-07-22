# 📋 نظام الحضور الذكي - واجهة الإدارة

<p align="center">
  <img src="assets/images/app_icon.png" alt="App Icon" width="150" height="150" />
</p>

<p align="center">
  <strong>Offline Attendance System - Admin App</strong><br/>
  نظام حضور ذكي يعمل بدون إنترنت لتسجيل ومتابعة حضور الطلاب
</p>

---

## 📖 جدول المحتويات

- [نظرة عامة](#-نظرة-عامة)
- [المميزات](#-المميزات)
- [التقنيات المستخدمة](#-التقنيات-المستخدمة)
- [المتطلبات](#-المتطلبات)
- [التثبيت والتشغيل](#-التثبيت-والتشغيل)
- [هيكل المشروع](#-هيكل-المشروع)
- [الشاشات والميزات](#-الشاشات-والميزات)
- [رخصة الاستخدام](#-رخصة-الاستخدام)

---

## 👁️ نظرة عامة

**نظام الحضور الذكي** هو تطبيق Flutter متكامل لإدارة وتسجيل حضور الطلاب بشكل **محلي (Offline)** دون الحاجة لاتصال بالإنترنت. يعمل التطبيق كـ **خادم HTTP محلي** يستقبل طلبات تسجيل الحضور من أجهزة الطلاب عبر شبكة Wi-Fi المحلية.

### ✨ الميزات الرئيسية

- 🔐 **مصادقة آمنة**: حماية التطبيق بكلمة مرور وبصمة الإصبع
- 📡 **خادم HTTP مدمج**: استقبال طلبات الحضور مباشرة بدون خادم خارجي
- 📱 **رمز QR ديناميكي**: توليد رموز QR فريدة لكل جلسة
- 📊 **لوحة تحكم شاملة**: إحصائيات وتقارير تفاعلية
- 💾 **قاعدة بيانات محلية**: تخزين البيانات باستخدام SQLite (Drift)
- 📤 **تصدير التقارير**: دعم Excel و PDF
- 🔄 **نسخ احتياطي واستعادة**: حماية البيانات
- 🌙 **وضع داكن/فاتح**: واجهة مستخدم متعددة الأوضاع
- 🌍 **دعم اللغة العربية**: واجهة RTL كاملة

---

## 🛠️ التقنيات المستخدمة

| التقنية | الاستخدام |
|---------|-----------|
| [Flutter 3.x](https://flutter.dev/) | إطار العمل الأساسي |
| [Dart 3.x](https://dart.dev/) | لغة البرمجة |
| [Riverpod](https://riverpod.dev/) | إدارة الحالة وDependency Injection |
| [Go Router](https://pub.dev/packages/go_router) | التنقل بين الشاشات |
| [Drift (SQLite)](https://drift.simonbinder.eu/) | قاعدة البيانات المحلية |
| [Shelf](https://pub.dev/packages/shelf) | خادم HTTP المدمج |
| [Freezed](https://freezed.dart.dev/) | إنشاء Models غير قابلة للتغيير |
| [Hive](https://docs.hivedb.org/) | التخزين المحلي السريع |
| [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications) | الإشعارات المحلية |
| [QR Flutter](https://pub.dev/packages/qr_flutter) | توليد رموز QR |
| [Excel & PDF](https://pub.dev/packages/excel) | تصدير التقارير |
| [FL Chart](https://fl-chart.dev/) | الرسوم البيانية |

---

## ⚙️ المتطلبات

### المتطلبات الأساسية

| البرنامج | الإصدار المطلوب |
|----------|----------------|
| **Flutter SDK** | >=3.2.0 <4.0.0 |
| **Dart SDK** | >=3.2.0 <4.0.0 |
| **Android Studio** | >=2022.1 أو VS Code مع امتداد Flutter |
| **Android SDK** | API 21+ (Android 5.0 Lollipop) |
| **Git** | لأغراض التحكم بالإصدار |

### الأجهزة المدعومة

- **Android**: API 21+ (Android 5.0 وأحدث)
- **iOS**: iOS 12.0+ (يتطلب Xcode للبناء)
- **RAM**: 2GB على الأقل موصى بها

---

## 🚀 التثبيت والتشغيل

### 1. استنساخ المشروع

```bash
git clone https://github.com/your-repo/attendance_admin.git
cd attendance_admin
```

### 2. تثبيت التبعيات

```bash
flutter pub get
```

### 3. تشغيل Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. تشغيل التطبيق

```bash
# في وضع التصحيح
flutter run

# أو لجهاز محدد
flutter run -d <device-id>
```

### 5. بناء APK للإنتاج

```bash
# APK عادي (للاختبار)
flutter build apk --debug

# APK مضغوط (للإصدار)
flutter build apk --release

# App Bundle (لتطبيق Google Play)
flutter build appbundle --release
```

---

## 📁 هيكل المشروع

```
lib/
├── main.dart                    # نقطة الدخول الرئيسية
├── app.dart                      # إعداد التطبيق
│
├── core/                         # الطبقة الأساسية المشتركة
│   ├── constants/                # الثوابت والرسائل
│   │   └── app_constants.dart
│   ├── di/                       # Dependency Injection (Riverpod Providers)
│   │   └── providers.dart
│   ├── extensions/               # الامتدادات المخصصة
│   │   └── extensions.dart
│   ├── router/                   # إعداد التنقل (Go Router)
│   │   └── app_router.dart
│   ├── theme/                    # السمات والألوان
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   └── utils/                    # الأدوات المساعدة
│       └── app_utils.dart
│
├── data/                         # طبقة البيانات
│   ├── models/                   # نماذج البيانات (Drift Tables + Freezed)
│   │   ├── models.dart
│   │   ├── student_model.dart
│   │   ├── attendance_model.dart
│   │   ├── session_model.dart
│   │   ├── organization_models.dart
│   │   └── system_models.dart
│   └── data_sources/
│       └── local/
│           └── local_database.dart
│
├── domain/                       # طبقة المنطق (Clean Architecture)
│   ├── entities/                 # الكيانات الأساسية
│   │   └── entities.dart
│   ├── repositories/             # المستودعات المجردة
│   │   └── repositories.dart
│   └── use_cases/                # حالات الاستخدام
│       └── use_cases.dart
│
├── presentation/                 # طبقة العرض (UI)
│   └── screens/                  # الشاشات
│       ├── screens.dart          # تصدير جميع الشاشات
│       ├── splash_screen.dart    # شاشة البداية
│       ├── login_screen.dart     # شاشة تسجيل الدخول
│       ├── main_screen.dart      # الشاشة الرئيسية (Navigation Shell)
│       ├── dashboard_screen.dart # لوحة التحكم
│       ├── session_create_screen.dart
│       ├── session_detail_screen.dart
│       ├── active_session_screen.dart
│       ├── attendance_list_screen.dart
│       ├── student_list_screen.dart
│       ├── student_form_screen.dart
│       ├── course_management_screen.dart
│       ├── section_management_screen.dart
│       ├── department_management_screen.dart
│       ├── reports_screen.dart
│       ├── settings_screen.dart
│       ├── backup_screen.dart
│       └── about_screen.dart
│
└── services/                     # الخدمات الخارجية
    ├── database/
    │   └── local_database.dart   # خدمة قاعدة البيانات
    ├── encryption/
    │   └── encryption_service.dart # خدمة التشفير
    ├── network/
    │   └── http_server_service.dart # خدمة الخادم HTTP
    ├── notification/
    │   └── notification_service.dart # خدمة الإشعارات
    └── storage/
        └── storage_service.dart  # خدمة التخزين المحلي

assets/
├── images/                       # الصور والأيقونات
├── icons/                        # الأيقونات
└── fonts/                        # الخطوط (Cairo)
    ├── Cairo-Regular.ttf
    ├── Cairo-Bold.ttf
    └── Cairo-Light.ttf
```

---

## 📱 الشاشات والميزات

### 🔐 شاشة المصادقة

| الشاشة | الوصف |
|--------|-------|
| **Splash Screen** | شاشة البداية مع الشعار والتحميل |
| **Login Screen** | تسجيل الدخول بكلمة المرور / البصمة |

### 📊 لوحة التحكم (Dashboard)

| الميزة | الوصف |
|--------|-------|
| **إحصائيات عامة** | عدد الطلاب، الجلسات النشطة، الحضور اليومي |
| **إنشاء جلسة جديدة** | بدء جلسة حضور جديدة |
| **الجلسات النشطة** | عرض وإدارة الجلسات الجارية |
| **سريع الوصول** | روابط سريعة للميزات الرئيسية |

### 👥 إدارة الطلاب

| الميزة | الوصف |
|--------|-------|
| **قائمة الطلاب** | عرض جميع الطلاب مع البحث والفلترة |
| **إضافة طالب** | نموذج إضافة طالب جديد |
| **تعديل طالب** | تعديل بيانات طالب موجود |
| **حذف طالب** | حذف طالب واحد أو متعدد |
| **استيراد** | استيراد قائمة طلاب من Excel |

### 📚 إدارة المؤسسة التعليمية

| الكيان | الوصف |
|--------|-------|
| **الأقسام (Departments)** | إدارة الأقسام الدراسية |
| **المستويات (Levels)** | المستويات الدراسية (1-4) |
| **الشعب (Sections)** | الشعب والفصول |
| **المقررات (Courses)** | المواد الدراسية |

### 📡 إدارة الجلسات

| الميزة | الوصف |
|--------|-------|
| **إنشاء جلسة** | اختيار المقرر والشعبة والتاريخ |
| **تفعيل الجلسة** | بدء خادم HTTP وتوليد QR |
| **عرض QR Code** | رمز QR للطلاب لمسحه |
| **مراقبة الحضور** | عرض الحضور الفعلي مباشرة |
| **إغلاق الجلسة** | إنهاء الجلسة وإيقاف الخادم |

### 📈 التقارير

| التقرير | الوصف |
|---------|-------|
| **تقرير الحضور** | حضور/غياب لجلسة محددة |
| **تقرير الطالب** | سجل حضور طالب محدد |
| **إحصائيات عامة** | رسوم بيانية تفاعلية |
| **تصدير Excel/PDF** | تصدير التقارير بصيغ مختلفة |

### ⚙️ الإعدادات

| الإعداد | الوصف |
|---------|-------|
| **كلمة المرور** | تغيير كلمة مرور المسؤول |
| **الوضع الداكن** | تفعيل/إيقاف الوضع الداكن |
| **منفذ الخادم** | تغيير رقم المنفذ الافتراضي |
| **النسخ الاحتياطي** | إنشاء نسخة احتياطية |
| **استعادة** | استعادة البيانات من نسخة احتياطية |

---

## 📄 رخصة الاستخدام

```
MIT License

Copyright (c) 2024 Attendance Admin Project

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🤝 المساهمة

نرحب بالمساهمات! يرجى قراءة [تعليمات المساهمة](CONTRIBUTING.md) قبل تقديم Pull Request.

## 📞 الدعم

- 📧 Email: support@attendance-admin.com
- 🐛 Issues: [GitHub Issues](https://github.com/your-repo/attendance_admin/issues)
- 📖 Documentation: [Wiki](https://github.com/your-repo/attendance_admin/wiki)

---

<p align="center">
  Made with ❤️ using Flutter
</p>
