import 'package:firebase_auth/firebase_auth.dart';

import '../models/userModel.dart';
import 'firebase.dart';

class AuthServices {
  static final AuthServices _instance = AuthServices._internal();
  factory AuthServices() => _instance;
  AuthServices._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService firebaseService = FirebaseService();

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
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await firebaseService.saveUser(user);
      return _userWithFirebaseUserID(user);
    } catch (err) {
      //print(err.toString());
      return null;
    }
  }

  //email and pass SignIn in
  Future sgnInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userWithFirebaseUserID(user);
    } catch (err) {
      //print(err.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
