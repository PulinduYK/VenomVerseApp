import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venomverse/Login_and_signup/Login_and_signup_logic/services/firebase.dart';
import 'package:venomverse/Profile/pages/about_us_page.dart';
import 'package:venomverse/Profile/pages/account_details_page.dart';
import 'package:venomverse/Profile/pages/help_page.dart';
import 'package:venomverse/Profile/pages/settings_edit_page.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

import '../../Login_and_signup/Login_and_signup_logic/authentication/wrapper.dart';

// SettingsPage displays the settings details.
class SettingsPage extends StatefulWidget {
  final Stream<String> usernameStream;
  //final String username;
  const SettingsPage({
    super.key,
    required this.usernameStream,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseService _firebaseService = FirebaseService();
  String email = '';
  String profileImage = '';
  @override
  void initState() {
    super.initState();
    fetchUserDataFromService();
  }

  Future<void> fetchUserDataFromService() async {
    Map<String, String> userData = await _firebaseService
        .fetchUserData(); // Call fetchUserData from FirebaseService

    setState(() {
      email = userData['email'] ?? 'Not Available';
      //profileImage = userData['profileImage'] ?? ''; // You can set this to the profile image if available
    });
  }

  void _showAddAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create New Account"),
          content: Text("Would you like to create a new account?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignupPage()),
                // );
              },
              child: Text("Proceed"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
      title: "Settings",
      contentHeightFactor: 0.85,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.width *
                  0.10), // For Space// For Space
          CircleAvatar(
            radius: 62.5, // 125 / 2
            backgroundColor: Color(0xFFD9D9D9), // Placeholder color
            backgroundImage: profileImage != '' && profileImage.isNotEmpty
                ? NetworkImage(profileImage) as ImageProvider
                : const AssetImage('assets/default_profile_picture.jpg'),
          ),
          SizedBox(height: 20), // For Space
          // StreamBuilder for username
          StreamBuilder<String>(
            stream: widget.usernameStream,
            builder: (context, snapshot) {
              String username = snapshot.data ?? "Guest User";
              return Text(
                username,
                style: GoogleFonts.inriaSans(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width > 350 ? 24 : 22,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          Text(
            email,
            style: GoogleFonts.inriaSans(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width > 350 ? 16 : 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width * 0.05), // For Space
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
                        MediaQuery.of(context).size.height * 0.06),
                    textStyle: GoogleFonts.inriaSans(
                        fontSize:
                            MediaQuery.of(context).size.width > 350 ? 24 : 18,
                        fontWeight: FontWeight.bold),
                    elevation: 5,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsEditPage()),
                    );
                  },
                  child: Text(
                    "Edit",
                  )),
              SizedBox(width: 10), // For Space between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(40, 40), // Adjusted size for better visibility
                  maximumSize: const Size(40, 40),
                  padding: EdgeInsets.zero, // Remove extra padding
                  shape: const CircleBorder(), // Makes it a perfect circle
                  elevation: 5,
                  backgroundColor: Colors.white,
                  // foregroundColor: Colors.black,
                ),
                onPressed: _showAddAccountDialog,
                child: const Icon(
                  Icons.add,
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          CustomButton(
            text: "Account details",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountDetailsPage()),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          CustomButton(
            text: "Security and Help",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          CustomButton(
            text: "About Us",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          // create Container for add that gradient effect
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB9161C), // 0%
                  Color(0xFFF28E8E), // 100%
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
              border: Border.all(
                // Adding stroke
                color: Colors.redAccent, // Change to desired stroke color
                width: 2, // Adjust thickness
              ),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.3, 50),
                  textStyle: GoogleFonts.inriaSans(
                    fontSize: MediaQuery.of(context).size.width > 350 ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 5,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Wrapper()),
                      (route) => false,
                    ); // Clears all previous routes);
                  }
                },
                child: Text(
                  "Log out",
                  textAlign: TextAlign.left,
                )),
          ),
        ],
      ),
    );
  }
}
