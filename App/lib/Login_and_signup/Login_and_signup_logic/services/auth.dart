import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'firebase.dart';

class AuthServices {
  static final AuthServices _instance = AuthServices._internal();
  factory AuthServices() => _instance;
  AuthServices._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService firebaseService = FirebaseService();

  User getUser() {
    return _auth.currentUser!;
  }

  bool verifyuser() {
    if (_auth.currentUser!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  Future reloadUser() async {
    await _auth.currentUser!.reload();
  }

  UserModel? _userWithFirebaseUserID(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }

  //Anonymous SignIn
  Future sgnInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserID(user);
    } catch (err) {
      //print(err.toString());
      return null;
    }
  }

  //email and pass SignIn in create
  Future createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await firebaseService.saveUser(user);
      return _userWithFirebaseUserID(user);
    } on FirebaseAuthException catch (err) {
      String errorMessage = "An error occurred. Please try again.";

      if (err.code == 'email-already-exists') {
        errorMessage = "This email is already in use.";
      } else if (err.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else if (err.code == 'weak-password') {
        errorMessage = "Your password is too weak.";
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }

      return null;
    }
  }

  //email and pass SignIn in
  Future sgnInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userWithFirebaseUserID(user);
    } on FirebaseAuthException catch (err) {
      String errorMessage = "An error occurred. Please try again.";
      if (err.code == 'invalid-credential') {
        errorMessage = "Invalid credential check credential again";
      } else {
        if (kDebugMode) {
          print(err.code);
        }
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }

      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
      return null;
    }
  }
}
