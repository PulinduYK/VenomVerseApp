import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';

// Settings edit page displays the edit version of the settings page.
class SettingsEditPage extends StatefulWidget {
  const SettingsEditPage({super.key});

  @override
  State<SettingsEditPage> createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  final FirebaseService _firebaseService = FirebaseService();
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Call updateUserData from FirebaseService
  Future<void> _updateUserData() async {
    await _firebaseService.updateUserData(
      name: _nameController.text,
      //email: _emailController.text,
      phone: _phoneController.text,
      dob: _dobController.text,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User data updated successfully!')),
      );
    }
  }

  // Load user data from FirebaseService
  Future<void> _loadUserData() async {
    Map<String, String> userData = await _firebaseService.getUserData();

    setState(() {
      _nameController.text = userData['name'] ?? '';
      //_emailController.text = userData['email'] ?? '';
      _phoneController.text = userData['phoneNumber'] ?? '';
      _dobController.text = userData['dob'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
      title: "Edit",
      contentHeightFactor: 0.85,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.width * 0.05), // For Space

          // Profile Picture Section
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 62.5,
                  backgroundColor: const Color(0xFFD9D9D9),
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/default_profile_picture.jpg')
                          as ImageProvider,
                ),
                if (_image == null)
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black54,
                      child:
                          Icon(Icons.camera_alt, size: 24, color: Colors.white),
                    ),
                  ),
                if (_image != null)
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.3 * 255).toInt()),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.075,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: const Icon(Icons.person),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          //SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //       width: MediaQuery.of(context).size.width *
          //           0.85, // 85% of screen width
          //       child: Container(
          //         constraints: BoxConstraints(
          //             minHeight: MediaQuery.of(context).size.height *
          //                 0.075), // Set minimum height
          //         child: TextField(
          //           controller: _emailController,
          //           decoration: InputDecoration(
          //             hintText: 'Email',
          //             prefixIcon: const Icon(Icons.email),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(30),
          //             ),
          //             errorText: _isEmailValid
          //                 ? null
          //                 : "Invalid email. Must end with @gmail.com",
          //           ),
          //           onChanged: _validateEmail,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.075,
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
          //   height: MediaQuery.of(context).size.height * 0.075,
          //   child: DropdownButtonFormField<String>(
          //     value: _selectedGender, // Ensure _selectedGender is initialized before using
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         _selectedGender = newValue!;
          //       });
          //     },
          //     decoration: InputDecoration(
          //       hintText: 'Select Gender',
          //       contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), // Added horizontal padding
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //     items: <String>['Male', 'Female', 'Other']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.075,
            child: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  // Format and set the selected date to the TextField
                  setState(() {
                    _dobController.text = '${pickedDate.toLocal()}'
                        .split(' ')[0]; // format to yyyy-mm-dd
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    hintText: 'Date of Birth',
                    prefixIcon: const Icon(Icons.calendar_today),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.07),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  // color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                      // offset: const Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.25, 50),
                      textStyle: GoogleFonts.inriaSans(
                        fontSize:
                            MediaQuery.of(context).size.width > 350 ? 20 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 5,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      ToastPopup.showToast("Not Saved");
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Discard",
                      textAlign: TextAlign.left,
                    )),
              ),
              const SizedBox(width: 15), // For Space between buttons

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff8A7FD6),
                      Color(0xff6D5FD5),
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
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.25, 50),
                      textStyle: GoogleFonts.inriaSans(
                        fontSize:
                            MediaQuery.of(context).size.width > 350 ? 20 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _updateUserData();
                      ToastPopup.showToast("Saved Successfully");
                      ToastPopup.showToast(
                          "Profile picture update not available in this version!");
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
                      textAlign: TextAlign.left,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
