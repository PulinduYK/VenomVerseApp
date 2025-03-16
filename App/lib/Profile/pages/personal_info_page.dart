import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venomverse/widgets/profile_page_template.dart';

// PersonalInfoPage displays the user's personal details.
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key,});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final FirebaseService _firebaseService = FirebaseService();
  String? userId;
  String dob = '';
  String gender = '';
  String phoneNumber = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    fetchUserPersonalData();
  }

  Future<void> fetchUserPersonalData() async {
    try {
      Map<String, String> userData = await _firebaseService.getUserData(); // Fetch all data

      setState(() {
        dob = userData['dob'] ?? 'Not Available';
        gender = userData['gender'] ?? 'Not Available';
        phoneNumber = userData['phoneNumber'] ?? 'Not Available';
        email = userData['email'] ?? 'Not Available';
      });
    } catch (e) {
      setState(() {
        dob = 'Error';
        gender = 'Error';
        phoneNumber = 'Error';
        email = 'Error';
      });
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Personal Info",
        contentHeightFactor: 0.85,
        child: Column(
          children:[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Date of Birth:",
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width:5),
                    Text(
                      dob,
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Gender:",
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      gender,
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Phone Number:",
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 16 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      phoneNumber,
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Email:",
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      email,
                      style: GoogleFonts.inriaSans(
                        color: Colors.black,
                        fontSize:  MediaQuery.of(context).size.width > 350 ? 18 : 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1C16B9), // 0%
                    Color(0xFFDC9FDA), // 100%
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,

                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    offset: const Offset(0, 5),
                    blurRadius: 10,

                  ),
                ],
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.03, MediaQuery.of(context).size.height * 0.06),
                    textStyle: GoogleFonts.inriaSans(
                      color: Colors.black,
                      fontSize:  MediaQuery.of(context).size.width > 350 ? 24 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 5,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                  },
                  child: Text(
                    "Edit",
                    textAlign: TextAlign.left,
                  )
              ),
            ),
          ],
        )
    );
  }
}
