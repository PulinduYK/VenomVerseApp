import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Functions/Hospital_suggestion/hospital_list.dart';

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

  Future<Map<String, String>> getUserData() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(_auth.currentUser?.uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return {
        'dob': data['dob'] ?? 'No dob',
        'name': data['name'] ?? 'No Name',
        'email': data['email'] ?? 'No Email',
        'profileImage': data['profileImage'] ?? '',
        'gender': data['gender'] ?? 'Not Available',
        'phoneNumber': data['phoneNumber'] ?? 'Not Available',
      };
    } else {
      return {
        'dob': 'No Date',
        'name': 'No Data',
        'email': 'No Data',
        'profileImage': '', // Default empty string for no image
        'gender': 'No Data',
        'phoneNumber': 'No Data',
      };
    }
  }

  Stream<String> getUserName() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data['name'] ?? 'No Name';
      } else {
        return 'No Data'; // If no data is found
      }
    });
  }

  Future<List<Hospital>> fetchHospitals(Position userLocation) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('hospitals').get();

      List<Hospital> hospitals = snapshot.docs.map((doc) {
        Hospital hospital = Hospital.fromFirestore(doc);
        hospital.distance = Geolocator.distanceBetween(
              userLocation.latitude,
              userLocation.longitude,
              hospital.latitude,
              hospital.longitude,
            ) /
            1000; // Convert to km
        return hospital;
      }).toList();

      hospitals.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

      return hospitals;
    } catch (e) {
      throw Exception("Error fetching hospitals: ${e.toString()}");
    }
  }

  /// Fetch only the remedies from Firestore for a given snake name.
  Future<List<String>> getRemedies(int type, String venomName) async {
    List<String> catList = ["snakes", "spiders", "insects"];
    String category = catList[type - 1];
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(category).doc(venomName).get();

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

  /// Fetch only the remedies from Firestore for a given snake name.
  Future<List<String>> getRemediesByName(int type, String venomName) async {
    List<String> catList = ["snakes", "spiders", "insects"];
    String category = catList[type - 1];
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(category).doc(venomName).get();

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
  Future<Map<String, String>> getVenomDetails(
      int type, String venomName) async {
    List<String> catList = ["snakes", "spiders", "insects"];
    String category = catList[type - 1];
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(category).doc(venomName).get();

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

  /// Fetch general details of the snake.
  Future<Map<String, String>> getVenomDetailsByName(
      int type, String venomName) async {
    List<String> catList = ["snakes", "spiders", "insects"];
    String category = catList[type - 1];
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(category).doc(venomName).get();

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

  // Fetch all snake species
  Future<List<Map<String, dynamic>>> getAllSnakes() async {
    return await getSpeciesWithImages("snakes");
  }

  // Fetch all spider species
  Future<List<Map<String, dynamic>>> getAllSpiders() async {
    return await getSpeciesWithImages("spiders");
  }

  // Fetch all insect species
  Future<List<Map<String, dynamic>>> getAllInsects() async {
    return await getSpeciesWithImages("insects");
  }

  // Fetch all species names & image paths for a given category
  Future<List<Map<String, dynamic>>> getSpeciesWithImages(
      String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(category).get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return {
          "name": data["name"] ?? "",
          "imagePath": data["imagePath"] ?? "",
        };
      }).toList();
    } catch (e) {
      print("Error fetching $category: $e");
      return [];
    }
  }

  Future<int> insertHistory(
      int UserSelectedType, bool success, bool previewStatus) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return 0;
    String Utype;
    List<String> type = [
      "Snake Category",
      "Spider Category",
      "Insect Category"
    ];
    if (UserSelectedType == 1) {
      Utype = type[UserSelectedType - 1];
    } else if (UserSelectedType == 2) {
      Utype = type[UserSelectedType - 1];
    } else if (UserSelectedType == 3) {
      Utype = type[UserSelectedType - 1];
    } else {
      Utype = "Error while saving history";
    }
    try {
      await _firestore
          .collection('usersHistory')
          .doc(userId)
          .collection('history')
          .add({
        'UserPreferredType': Utype,
        'status': success ? 'Success' : 'Failure',
        'previewStatus': previewStatus ? 'Shown' : 'Restricted',
        'timestamp': FieldValue.serverTimestamp(),
      });
      return 1; // Success
    } catch (e) {
      print("Error inserting history: $e");
      return 0; // Failure
    }
  }

  Stream<List<Map<String, dynamic>>> getHistoryStream() {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]); // Return an empty stream if userId is null
    }

    try {
      return _firestore
          .collection('usersHistory')
          .doc(userId)
          .collection('history')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) {
                return {
                  'id': doc.id,
                  'UserPreferredType': doc['UserPreferredType'],
                  'status': doc['status'],
                  'previewStatus': doc['previewStatus'],
                  'timestamp':
                      doc['timestamp']?.toDate().toString() ?? "Unknown",
                };
              }).toList());
    } catch (e) {
      print("Error fetching history stream: $e");
      return Stream.value([]); // Return an empty stream on error
    }
  }

  Future<void> clearHistory() async {
    String? userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        var collection = _firestore
            .collection('usersHistory')
            .doc(userId)
            .collection('history');
        var snapshots = await collection.get();
        for (var doc in snapshots.docs) {
          await doc.reference.delete();
        }
      } catch (e) {
        print("Error clearing history: $e");
      }
    }
  }

  Future<void> deleteHistory(String historyId) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      await _firestore
          .collection('usersHistory')
          .doc(userId)
          .collection('history')
          .doc(historyId)
          .delete();
    } catch (e) {
      print("Error deleting history: $e");
    }
  }
}
