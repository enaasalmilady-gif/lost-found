<div dir="rtl">

# تطبيق لقيتها

مشروع مادة Flutter - كلية التقنية الإلكترونية

---

## نبذة عن المشروع


هذا التطبيق هو نظام ذكي لإدارة المفقودات والموجودات، يهدف إلى تسهيل عملية الإبلاغ عن الأشياء المفقودة أو التي تم العثور عليها داخل اي منظقة. يتيح للمستخدمين إضافة تفاصيل دقيقة عن الأغراض المفقودة أو المعثور عليها، مع إمكانية تصفّح قائمة محدثة بالأغراض المتاحة.

يعتمد التطبيق على تمكين التواصل المباشر بين المستخدمين عبر رقم الهاتف، مما يسرّع من عملية استرجاع الأغراض دون الحاجة إلى وسطاء.

تم تطوير التطبيق باستخدام إطار العمل Flutter لضمان تجربة استخدام سلسة ومتوافقة مع مختلف أنظمة التشغيل، كما تم ربطه بخدمات Firebase لإدارة المصادقة، تخزين البيانات، وتحديث المحتوى بشكل فوري وآمن




### المميزات:
- تسجيل الدخول وإنشاء حساب جديد
- إضافة عنصر مفقود أو موجود مع صورة ووصف
- عرض جميع العناصر المسجلة
- البحث والتصفية
- الوضع الليلي

---

## المتطلبات

لتشغيل المشروع يجب توفر البرامج التالية:

1. **Flutter SDK** - يمكن تحميله من [هنا](https://flutter.dev/docs/get-started/install)
2. **Android Studio** - يمكن تحميله من [هنا](https://developer.android.com/studio)
3. **Git** - يمكن تحميله من [هنا](https://git-scm.com/)

للتأكد من أن Flutter يعمل بشكل صحيح، قم بتنفيذ الأمر التالي:
```
flutter doctor
```

---

## خطوات تشغيل المشروع

### 1. تحميل المشروع

```
git clone https://github.com/YOUR_USERNAME/lost-and-found-app.git
cd lost-and-found-app
```

### 2. تثبيت الحزم

```
flutter pub get
```

### 3. إعداد Firebase

المشروع يستخدم Firebase، لذلك يجب إنشاء مشروع Firebase خاص:

1. انتقل إلى [Firebase Console](https://console.firebase.google.com/)
2. أنشئ مشروعاً جديداً
3. أضف تطبيق Android واستخدم اسم الحزمة: `com.example.untitled1`
4. قم بتحميل ملف `google-services.json` وضعه في مجلد `android/app/`
5. فعّل الخدمات التالية من Firebase Console:
   - Authentication: انتقل إلى Sign-in method وفعّل Email/Password
   - Firestore Database: أنشئ قاعدة بيانات جديدة
   -ImageBB:
 6.لرفع الصور عبر ImageBB، يجب إنشاء حساب في ImageBB والحصول على API Key.
 أنشئ ملفًا باسم lib/secrets.dart وضع فيه:
 dart  const String imageBBApiKey = 'ضع_مفتاحك_هنا';  
 -

```
flutter run
```

---

## المشاكل الشائعة وحلولها

### مشكلة: Build failed أو Gradle error

قم بتنفيذ الأوامر التالية بالترتيب:
```
flutter clean
flutter pub get
flutter run
```

إذا لم تُحل المشكلة، انتقل إلى مجلد android ونفذ:
```
cd android
./gradlew clean
cd ..
flutter run
```

---

### مشكلة: No Firebase App '[DEFAULT]' has been created

هذا الخطأ يعني أن Firebase غير مُعد بشكل صحيح. تأكد من:
- وجود ملف `google-services.json` في مجلد `android/app/`
- تطابق اسم الحزمة مع المسجل في Firebase

---

### مشكلة: فشل تسجيل الدخول

1. تأكد من تفعيل Email/Password في Firebase Console

```
cd android
./gradlew signingReport
```


---

#### مشكلة: فشل رفع الصور

التطبيق يستخدم خدمة ImgBB لرفع الصور. إذا فشل الرفع:
1. تأكد من اتصال الجهاز بالإنترنت
2. تأكد من أن مفتاح API صالح في ملف `lib/services/image_upload_service.dart`
3. تأكد من أن حجم الصورة لا يتجاوز 32 ميجابايت

---

### مشكلة: بطء التطبيق أو توقفه

قم بزيادة الذاكرة المخصصة لـ Gradle. انتقل إلى ملف `android/gradle.properties` وأضف:

```
org.gradle.jvmargs=-Xmx4096m
```

---

## هيكل المشروع

```
lib/
├── main.dart                    # الملف الرئيسي
├── firebase_options.dart        # إعدادات Firebase
├── models/
│   └── lost_item.dart           # نموذج العنصر
├── screens/
│   ├── login_screen.dart        # شاشة تسجيل الدخول
│   ├── home_screen.dart         # الشاشة الرئيسية
│   ├── add_item_screen.dart     # شاشة إضافة عنصر
│   ├── item_details_screen.dart # شاشة تفاصيل العنصر
│   └── settings_screen.dart     # شاشة الإعدادات
├── services/
│   ├── auth_service.dart        # خدمة المصادقة
│   ├── firestore_service.dart   # خدمة قاعدة البيانات
│   └── image_upload_service.dart # خدمة رفع الصور
└── providers/
    └── settings_provider.dart   # مزود الإعدادات
```

---

## بناء ملف APK

لبناء نسخة الإصدار:

```
flutter build apk --release
```

الملف الناتج يكون في: `build/app/outputs/flutter-apk/app-release.apk`

---

## التقنيات المستخدمة

- Flutter و Dart
- Firebase للمصادقة وقاعدة البيانات والتخزين
- Provider لإدارة الحالة
- SharedPreferences: لحفظ الاعدادات الخاصة باللون واالوضع الليلي فقط

  ملاحظة:

  لم يتم استخدام shared-prefreces في تسجيل الدخول,
  كل ما يتعلق بحساب المستخدم والجلسة يتم عبر Firebase Auth فقط. 
---



## خطط التطوير المستقبلية
خطط لتطوير التطبيق مستقبلًا ليشمل نظام تحديد الموقع الجغرافي لعرض المفقودات حسب منطقة المستخدم، مع دعم الإشعارات الفورية، الدردشة داخل التطبيق، والتعليقات على الأغراض المفقودة. كما سيتم توفير وضع الزائر، وإمكانية إدارة الملف الشخصي وتعديل البيانات، بهدف تحسين تجربة المستخدم وتعزيز التفاعل المجتمعي.

تم بحمد الله

</div>
