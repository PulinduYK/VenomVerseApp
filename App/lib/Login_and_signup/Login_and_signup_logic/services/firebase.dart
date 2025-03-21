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

  // Fetch user data
  Future<Map<String, String>> fetchUserData() async {
    try {
      // Assuming the user is logged in, you fetch their document from Firestore
      var user = _auth.currentUser;

      if (user != null) {
        // Get user data from Firestore using the user's UID
        DocumentSnapshot userDataSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDataSnapshot.exists) {
          // Return the user data as a map
          var userData = userDataSnapshot.data() as Map<String, dynamic>;
          return {
            'email': userData['email'] ?? 'Not Available',
            //'profileImage': userData['profileImage'] ?? 'default_image_url',
          };
        } else {
          return {'email': 'No user data available'};
        }
      } else {
        return {'email': 'User not logged in'};
      }
    } catch (e) {
      print('Error retrieving user data: $e');
      return {'email': 'Error'};
    }
  }

  Future<void> updateFirst(
      String newName, String dob, String gender, String allergies) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': newName,
          'dob': dob,
          'gender': gender,
          'allergies': allergies,
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
        'uid': data['uid'] ?? 'No dob',
        'profileImage': data['profileImage'] ?? '',
        'gender': data['gender'] ?? 'Not Available',
        'phoneNumber': data['phoneNumber'] ?? 'Not Available',
        'allergies': data['allergies'] ?? 'Not Available',
      };
    } else {
      return {
        'dob': 'No Date',
        'name': 'No Data',
        'email': 'No Data',
        'uid': 'uid',
        'profileImage': '', // Default empty string for no image
        'gender': 'No Data',
        'phoneNumber': 'No Data',
        'allergies': 'No Data',
      };
    }
  }

  // Update user data
  Future<void> updateUserData({
    required String name,
    //required String email,
    required String phone,
    required String dob,
  }) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        'name': name,
        //'email': email,
        'phone': phone,
        'dob': dob,
      }, SetOptions(merge: true));

      print("User data updated successfully!");
    } catch (e) {
      print("Error updating user data: $e");
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

  Future<int> insertHistory(int UserSelectedType, bool success,
      bool previewStatus, String name) async {
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
        'detectedName': name,
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
      return Stream.value(
          []); // Return an empty stream if user is not logged in
    }

    return _firestore
        .collection('usersHistory')
        .doc(userId)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  'id': doc.id,
                  'UserPreferredType':
                      doc.data().containsKey('UserPreferredType')
                          ? doc['UserPreferredType']
                          : "None",
                  'status':
                      doc.data().containsKey('status') ? doc['status'] : "None",
                  'previewStatus': doc.data().containsKey('previewStatus')
                      ? doc['previewStatus']
                      : "None",
                  'detectedName': doc.data().containsKey('detectedName')
                      ? doc['detectedName']
                      : "None",
                  'timestamp': (doc.data().containsKey('timestamp') &&
                          doc['timestamp'] is Timestamp)
                      ? (doc['timestamp'] as Timestamp).toDate().toString()
                      : "None",
                })
            .toList());
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
