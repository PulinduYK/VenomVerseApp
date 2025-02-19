import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUser(User? user) async {
    try {
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print("Error updating name: $e");
    }
  }

  Future<void> updateFirst(String newName, String dob, String gender) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': newName,
          'dob': dob,
          'gender': gender,
        });
        print("Name updated successfully");
      }
    } catch (e) {
      print("Error updating name: $e");
    }
  }

  Future<void> updateName(String newName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'displayName': newName,
        });
        print("Name updated successfully");
      }
    } catch (e) {
      print("Error updating name: $e");
    }
  }

  Future<void> updateDateOfBirth(String newName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'displayName': newName,
        });
        print("Name updated successfully");
      }
    } catch (e) {
      print("Error updating name: $e");
    }
  }

  Future<void> updatePhoneNumber(String newName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'displayName': newName,
        });
        print("Name updated successfully");
      }
    } catch (e) {
      print("Error updating name: $e");
    }
  }
}
