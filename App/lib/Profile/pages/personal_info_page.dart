import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';


// PersonalInfoPage displays the user's personal details.
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key,});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
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
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userId = user.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          setState(() {
            dob = userDoc['dob'];
            gender = userDoc['gender'];
            phoneNumber = userDoc['phoneNumber'];
            email = userDoc['email'];
          });
        } else {
          setState(() {
            dob = 'Not Available';
            gender = 'Not Available';
            phoneNumber = 'Not Available';
            email = 'Not Available';
          });
        }
      } else {
        setState(() {
          dob = 'User not logged in';
          gender = '';
          phoneNumber = '';
          email = '';
        });
      }
    } catch (e) {
      setState(() {
        dob = 'Error';
        gender = 'Error';
        phoneNumber = 'Error';
        email = 'Error';
      });
      print('Error retrieving name: $e');
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
