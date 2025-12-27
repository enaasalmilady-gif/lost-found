// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled1/main.dart';

void main() {
  testWidgets('Login Screen UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // The app now starts with LostAndFoundApp, which shows the LoginScreen.
    await tester.pumpWidget(const LostAndFoundApp());

    // Verify that the AppBar title and the login button text are displayed.
    // Both widgets use the same text, so we expect to find it twice.
    expect(find.text('تسجيل الدخول'), findsNWidgets(2));

    // Verify that the email and password fields are displayed by their label text.
    expect(find.text('البريد الإلكتروني'), findsOneWidget);
    expect(find.text('كلمة المرور'), findsOneWidget);

    // Verify that there is one ElevatedButton (the login button).
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that the old counter widgets from the default app are no longer present.
    expect(find.text('0'), findsNothing);
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
