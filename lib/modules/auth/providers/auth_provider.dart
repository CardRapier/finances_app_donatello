import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final formLogin = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)]),
  });

  Future<bool> signIn() async {
    loading = true;
    try {
      final email = formLogin.control('email').value;
      final password = formLogin.control('password').value;
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      loading = false;
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      formLogin.reset();
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
