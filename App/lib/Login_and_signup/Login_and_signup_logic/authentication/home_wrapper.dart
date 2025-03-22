import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Functions/Pages/home_page.dart';
import '../../signup/register/birthdaygenderpage.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  Future<bool> hasNameField() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return false; // No user logged in

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) return false; // No document found

      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

      return data != null &&
          data.containsKey('name') &&
          data['name'] != null &&
          data['name'].toString().isNotEmpty;
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasNameField(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Error loading data")),
          );
        }

        if (!snapshot.hasData || snapshot.data == false) {
          return const BirthdayGenderPage();
        }

        return const HomePage();
      },
    );
  }
}
