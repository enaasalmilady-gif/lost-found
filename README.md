# 🔍 Lost & Found App | تطبيق المفقودات والموجودات

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

**تطبيق Flutter لإدارة المفقودات والموجودات مع دعم Firebase**

[English](#english) | [العربية](#العربية)

</div>

---

## العربية

### 📱 وصف التطبيق

تطبيق **المفقودات والموجودات** هو تطبيق موبايل مبني بـ Flutter يساعد المستخدمين في:

- ✅ **تسجيل المفقودات**: إضافة عناصر مفقودة مع الصور والوصف
- ✅ **تسجيل الموجودات**: إضافة عناصر تم العثور عليها
- ✅ **البحث والتصفية**: البحث عن العناصر حسب النوع
- ✅ **المصادقة**: تسجيل الدخول والخروج بـ Firebase Auth
- ✅ **رفع الصور**: دعم رفع صور العناصر
- ✅ **الوضع المظلم**: دعم الوضع الليلي
- ✅ **متعدد اللغات**: دعم العربية والإنجليزية

### 🛠️ المتطلبات

قبل البدء، تأكد من تثبيت:

| المتطلب | الإصدار المطلوب | رابط التحميل |
|---------|-----------------|--------------|
| Flutter SDK | 3.10.0 أو أحدث | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart SDK | 3.0.0 أو أحدث | يأتي مع Flutter |
| Android Studio | آخر إصدار | [developer.android.com](https://developer.android.com/studio) |
| VS Code (اختياري) | آخر إصدار | [code.visualstudio.com](https://code.visualstudio.com/) |

### 🚀 خطوات التثبيت

#### الخطوة 1: استنساخ المشروع

```bash
git clone https://github.com/YOUR_USERNAME/lost-and-found-app.git
cd lost-and-found-app
```

#### الخطوة 2: تثبيت الحزم

```bash
flutter pub get
```

#### الخطوة 3: إعداد Firebase

> ⚠️ **مهم جداً**: يجب إعداد Firebase الخاص بك

1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. أنشئ مشروع جديد
3. أضف تطبيق Android:
   - **Package name**: `com.example.untitled1` (أو غيّره في `android/app/build.gradle.kts`)
4. حمّل ملف `google-services.json` وضعه في `android/app/`
5. فعّل الخدمات التالية في Firebase Console:
   - **Authentication** → Email/Password
   - **Firestore Database**
   - **Storage**

#### الخطوة 4: تحديث ملف Firebase Options

قم بتشغيل الأمر التالي أو عدّل الملف يدوياً:

```bash
flutterfire configure
```

#### الخطوة 5: تشغيل التطبيق

```bash
flutter run
```

### ⚠️ الأخطاء الشائعة وحلولها

<details>
<summary><b>❌ خطأ: "FAILURE: Build failed with an exception"</b></summary>

**السبب**: مشكلة في Gradle أو تعارض إصدارات

**الحل**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```
</details>

<details>
<summary><b>❌ خطأ: "No Firebase App '[DEFAULT]' has been created"</b></summary>

**السبب**: Firebase غير مُهيّأ بشكل صحيح

**الحل**:
1. تأكد من وجود `google-services.json` في `android/app/`
2. تأكد من تطابق `package name` مع Firebase
3. تأكد من استدعاء `Firebase.initializeApp()` في `main.dart`
</details>

<details>
<summary><b>❌ خطأ: "PlatformException(sign_in_failed)"</b></summary>

**السبب**: مشكلة في إعداد Authentication

**الحل**:
1. تأكد من تفعيل Email/Password في Firebase Console
2. تحقق من SHA-1 fingerprint:
```bash
cd android
./gradlew signingReport
```
3. أضف SHA-1 في Firebase Console → Project Settings → Your Apps
</details>

<details>
<summary><b>❌ خطأ: "Permission denied" عند رفع الصور</b></summary>

**السبب**: قواعد Firebase Storage

**الحل**: عدّل قواعد Storage في Firebase Console:
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```
</details>

<details>
<summary><b>❌ خطأ: "Gradle build daemon disappeared unexpectedly"</b></summary>

**السبب**: نقص في الذاكرة

**الحل**: أضف في `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=1024m
org.gradle.daemon=true
org.gradle.parallel=true
```
</details>

<details>
<summary><b>❌ خطأ: "requires-recent-login" عند حذف الحساب</b></summary>

**السبب**: Firebase يتطلب إعادة تسجيل الدخول للعمليات الحساسة

**الحل**: التطبيق يعالج هذا تلقائياً ويطلب كلمة المرور
</details>

### 📂 هيكل المشروع

```
lib/
├── main.dart                 # نقطة البداية
├── firebase_options.dart     # إعدادات Firebase
├── models/
│   └── lost_item.dart        # نموذج العنصر المفقود
├── screens/
│   ├── login_screen.dart     # شاشة تسجيل الدخول
│   ├── home_screen.dart      # الشاشة الرئيسية
│   ├── add_item_screen.dart  # إضافة عنصر جديد
│   ├── item_details_screen.dart  # تفاصيل العنصر
│   └── settings_screen.dart  # الإعدادات
├── services/
│   ├── auth_service.dart     # خدمة المصادقة
│   ├── firestore_service.dart # خدمة Firestore
│   └── image_upload_service.dart # خدمة رفع الصور
└── providers/
    └── settings_provider.dart # مزود الإعدادات
```

### 🔧 إعدادات إضافية

#### تغيير اسم التطبيق

في `android/app/src/main/AndroidManifest.xml`:
```xml
android:label="اسم التطبيق"
```

#### تغيير أيقونة التطبيق

استبدل الملفات في:
- `android/app/src/main/res/mipmap-*/ic_launcher.png`

### 📱 بناء APK للنشر

```bash
flutter build apk --release
```

الملف الناتج: `build/app/outputs/flutter-apk/app-release.apk`

---

## English

### 📱 Description

**Lost & Found App** is a Flutter mobile application that helps users:

- ✅ **Report Lost Items**: Add lost items with photos and descriptions
- ✅ **Report Found Items**: Add items that have been found
- ✅ **Search & Filter**: Search items by type
- ✅ **Authentication**: Login/logout with Firebase Auth
- ✅ **Image Upload**: Support for item photo uploads
- ✅ **Dark Mode**: Night mode support
- ✅ **Multilingual**: Arabic and English support

### 🛠️ Requirements

| Requirement | Version | Download |
|-------------|---------|----------|
| Flutter SDK | 3.10.0+ | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart SDK | 3.0.0+ | Included with Flutter |
| Android Studio | Latest | [developer.android.com](https://developer.android.com/studio) |

### 🚀 Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/lost-and-found-app.git

# Navigate to project
cd lost-and-found-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### ⚙️ Firebase Setup

1. Create a project at [Firebase Console](https://console.firebase.google.com/)
2. Add an Android app with package name `com.example.untitled1`
3. Download `google-services.json` to `android/app/`
4. Enable Authentication (Email/Password), Firestore, and Storage

### 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

<div align="center">
Made with ❤️ using Flutter
</div>
