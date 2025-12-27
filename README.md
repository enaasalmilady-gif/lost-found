# تطبيق المفقودات والموجودات 📱

مشروع تخرج / مشروع مادة برمجة تطبيقات الموبايل

---

## نبذة عن المشروع

هذا التطبيق عبارة عن نظام لإدارة المفقودات والموجودات، بحيث يقدر المستخدم يسجل الأشياء اللي ضاعت منه أو الأشياء اللي لقاها. التطبيق مبني بـ Flutter ومربوط بـ Firebase.

### المميزات:
- تسجيل دخول وإنشاء حساب
- إضافة عنصر مفقود أو موجود مع صورة ووصف
- عرض كل العناصر المسجلة
- البحث والفلترة
- الوضع الليلي
- يدعم العربي والإنجليزي

---

## البرامج المطلوبة

عشان تشغل المشروع لازم يكون عندك:

1. **Flutter SDK** - حمله من [هنا](https://flutter.dev/docs/get-started/install)
2. **Android Studio** - حمله من [هنا](https://developer.android.com/studio)
3. **Git** - حمله من [هنا](https://git-scm.com/)

تأكد إن Flutter شغال عندك:
```bash
flutter doctor
```

---

## طريقة تشغيل المشروع

### 1. حمل المشروع

```bash
git clone https://github.com/YOUR_USERNAME/lost-and-found-app.git
cd lost-and-found-app
```

### 2. حمل الـ packages

```bash
flutter pub get
```

### 3. إعداد Firebase (مهم جداً!)

المشروع يستخدم Firebase، فلازم تسوي مشروع Firebase خاص فيك:

1. روح على [Firebase Console](https://console.firebase.google.com/)
2. اسوِ مشروع جديد
3. أضف تطبيق Android واستخدم الـ package name: `com.example.untitled1`
4. حمّل ملف `google-services.json` وحطه في مجلد `android/app/`
5. فعّل الخدمات التالية من Firebase Console:
   - Authentication → روح على Sign-in method وفعّل Email/Password
   - Firestore Database → اسوِ database جديدة
   - Storage → فعّله عشان رفع الصور

### 4. شغّل التطبيق

```bash
flutter run
```

---

## المشاكل الشائعة وحلولها

### مشكلة: "Build failed" أو "Gradle error"

جرب هالأوامر بالترتيب:
```bash
flutter clean
flutter pub get
flutter run
```

لو ما اشتغل، روح لمجلد android واكتب:
```bash
cd android
./gradlew clean
cd ..
flutter run
```

---

### مشكلة: "No Firebase App '[DEFAULT]' has been created"

هذي تعني إن Firebase مو مضبوط صح. تأكد من:
- ملف `google-services.json` موجود في `android/app/`
- الـ package name متطابق مع اللي في Firebase

---

### مشكلة: فشل تسجيل الدخول

1. تأكد إنك مفعّل Email/Password في Firebase Console
2. لازم تضيف SHA-1 fingerprint في Firebase:

```bash
cd android
./gradlew signingReport
```

انسخ الـ SHA-1 وأضفه في:
Firebase Console → Project Settings → Your Apps → Add fingerprint

---

### مشكلة: ما يرفع الصور / Permission denied

روح Firebase Console → Storage → Rules وغيّرها لـ:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

### مشكلة: "requires-recent-login" لما أحذف الحساب

هذي طبيعية، Firebase يطلب تسجيل دخول جديد للعمليات الحساسة. التطبيق يعالجها تلقائياً.

---

### مشكلة: التطبيق بطيء أو يعلق

جرب تزيد RAM للـ Gradle. روح لـ `android/gradle.properties` وأضف:

```
org.gradle.jvmargs=-Xmx4096m
```

---

## ملفات المشروع

```
lib/
├── main.dart                    # الملف الرئيسي
├── firebase_options.dart        # إعدادات Firebase
├── models/
│   └── lost_item.dart           # موديل العنصر
├── screens/
│   ├── login_screen.dart        # صفحة الدخول
│   ├── home_screen.dart         # الصفحة الرئيسية
│   ├── add_item_screen.dart     # إضافة عنصر
│   ├── item_details_screen.dart # تفاصيل العنصر
│   └── settings_screen.dart     # الإعدادات
├── services/
│   ├── auth_service.dart        # خدمة تسجيل الدخول
│   ├── firestore_service.dart   # خدمة قاعدة البيانات
│   └── image_upload_service.dart # خدمة رفع الصور
└── providers/
    └── settings_provider.dart   # للثيم واللغة
```

---

## بناء APK

عشان تبني نسخة release:

```bash
flutter build apk --release
```

الملف بيكون في: `build/app/outputs/flutter-apk/app-release.apk`

---

## التقنيات المستخدمة

- Flutter & Dart
- Firebase (Auth, Firestore, Storage)
- Provider للـ State Management
- SharedPreferences لحفظ الإعدادات

---

## للتواصل

لو واجهت أي مشكلة تواصل معي أو افتح Issue في GitHub.

---

تم بحمد الله ✨
