import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // البث لحالة المستخدم (تسجيل الدخول/الخروج)
  Stream<User?> get user => _auth.authStateChanges();

  // الحصول على المستخدم الحالي
  User? get currentUser => _auth.currentUser;

  // تسجيل حساب جديد
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth Error (Register): ${e.code} - ${e.message}');
      rethrow;
    }
  }

  // تسجيل الدخول
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth Error (SignIn): ${e.code} - ${e.message}');
      rethrow;
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // حذف الحساب
  Future<void> deleteAccount() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.delete();
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth Error (Delete): ${e.code} - ${e.message}');
      rethrow;
    }
  }
}
