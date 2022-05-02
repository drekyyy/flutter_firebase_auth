import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/user.dart';
import 'package:flutter_shopping_list/services/database_service.dart';

class AuthenticationService {
  final FirebaseAuth _auth;
  AuthenticationService(this._auth);

  SimpleUser? _userfromFirebaseUser(User? user) {
    return user != null ? SimpleUser(user.uid) : null;
  }

  Stream<SimpleUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebaseUser(user));
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      var emsg;
      if (e.message != null) emsg = e.message;
      log(emsg);
      return e.message;
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      await DatabaseService(user.uid).updateUserData(email);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
