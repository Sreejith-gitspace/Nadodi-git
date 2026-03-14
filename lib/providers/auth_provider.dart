import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool isLoading = true;
  String? error;

  AuthProvider() {
    AuthService.instance.authStateChanges.listen((firebaseUser) {
      user = firebaseUser;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await AuthService.instance.signInWithEmail(email, password);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await AuthService.instance.registerWithEmail(email, password);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await AuthService.instance.signOut();
    user = null;
    notifyListeners();
  }
}
