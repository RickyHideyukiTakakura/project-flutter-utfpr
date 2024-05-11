import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? activeUser;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _getUser() {
    activeUser = _auth.currentUser;

    notifyListeners();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      activeUser = (user == null) ? null : user;
      isLoading = false;

      notifyListeners();
    });
  }

  signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (error) {
      final errorMessages = {
        'weak-password': 'Password is weak',
        'email-already-in-use': 'Email is already in use',
      };

      throw AuthException(
        errorMessages[error.code].toString(),
      );
    }
  }

  signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _getUser();
    } on FirebaseAuthException catch (error) {
      final errorMessages = {
        'invalid-email': 'Invalid format email',
        'wrong-password': 'Credentials invalid',
        'user-not-found': 'Credentials invalid',
      };

      // Use a default message for any other errors that are not explicitly handled above
      String errorMessage = errorMessages[error.code] ??
          'An unexpected error occurred, please try again later';

      throw AuthException(errorMessage);
    }
  }

  signOut() async {
    await _auth.signOut();
    _getUser();
  }
}
