import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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

  final formRegister = FormGroup(
    {
      'name': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(8)]),
      'passwordConfirmation': FormControl<String>(),
    },
    validators: [
      Validators.mustMatch('password', 'passwordConfirmation',
          markAsDirty: true),
    ],
  );

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
      loading = false;
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

  Future<bool> signUp() async {
    loading = true;
    try {
      final email = formRegister.control('email').value;
      final password = formRegister.control('password').value;
      final name = formRegister.control('name').value;
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await users.doc(credentials.user!.uid).set({'debts': [], 'finances': []});
      await assignDisplayName(name);
      loading = false;
      return true;
    } on FirebaseAuthException catch (e) {
      loading = false;
      return false;
    }
  }

  Future<void> assignDisplayName(name) async {
    final user = _firebaseAuth.currentUser;
    await user?.updateDisplayName(name);
  }
}
