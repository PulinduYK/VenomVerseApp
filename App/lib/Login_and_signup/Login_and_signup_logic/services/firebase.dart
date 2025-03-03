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

  // Stream function to get user data as string variables
  Stream<Map<String, String>> getUserData() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return {
          'name': data['name'] ?? 'No Name',
          'email': data['email'] ?? 'No Email',
          'profileImage': data['profileImage'] ?? '',
        };
      } else {
        return {
          'name': 'No Data',
          'email': 'No Data',
          'profileImage': '', // Default empty string for no image
        };
      }
    });
  }

  /// Fetch only the remedies from Firestore for a given snake name.
  Future<List<String>> getRemedies(String snakeName) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('snakes').doc(snakeName).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return data.entries
            .where((entry) => entry.key.startsWith('remedi'))
            .map((entry) => entry.value.toString())
            .toList();
      }
    } catch (e) {
      print("Error fetching remedies: $e");
    }
    return [];
  }

  /// Fetch general details of the snake.
  Future<Map<String, String>> getSnakeDetails(String snakeName) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('snakes').doc(snakeName).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return {
          "name": data["name"] ?? "",
          "description": data["description"] ?? "",
          "lethalityLevel": data["lethalityLevel"] ?? "",
          "imagePath": data["imagePath"] ?? "",
        };
      }
    } catch (e) {
      print("Error fetching snake details: $e");
    }
    return {};
  }
}
