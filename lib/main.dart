import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const LostAndFoundApp(),
    ),
  );
}

/// الويدجت الرئيسي للتطبيق
class LostAndFoundApp extends StatelessWidget {
  const LostAndFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'Lost & Found',
      debugShowCheckedModeBanner: false,

      // إعدادات اللغة (مثبتة على العربية)
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // الوضع العادي والوضع الليلي
      themeMode: settings.themeMode,
      // الوضع العادي
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: settings.seedColor,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color.alphaBlend(
          settings.seedColor.withOpacity(0.05),
          Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: settings.seedColor,
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
        ),
      ),
      // الوضع الليلي
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: settings.seedColor,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.alphaBlend(
          settings.seedColor.withOpacity(0.20), // Increased tint
          const Color(0xFF121212),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: settings.seedColor, // Solid, no opacity
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
        ),
      ),

      // الشاشة التي يبدأ بها التطبيق
      home: StreamBuilder<User?>(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return HomeScreen(userEmail: snapshot.data!.email ?? '---');
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
