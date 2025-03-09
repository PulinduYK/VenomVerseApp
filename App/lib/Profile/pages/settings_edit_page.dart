import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venomverse/widgets/profile_page_template.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Settings edit page displays the edit version of the settings page.
class SettingsEditPage extends StatefulWidget {
  const SettingsEditPage({super.key});

  @override
  State<SettingsEditPage> createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;


  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
      title: "Edit",
      contentHeightFactor: 0.85,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.05), // For Space

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
                      : const AssetImage('assets/default_profile_picture.jpg') as ImageProvider,
                ),
                if (_image == null)
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.camera_alt, size: 24, color: Colors.white),
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
            width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
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
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.075,
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
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
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            height: MediaQuery.of(context).size.height * 0.075,
            child: DropdownButtonFormField<String>(
              value: _selectedGender, // Ensure _selectedGender is initialized before using
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
              decoration: InputDecoration(
                hintText: 'Select Gender',
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), // Added horizontal padding
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
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
                    _dobController.text = '${pickedDate.toLocal()}'.split(' ')[0]; // format to yyyy-mm-dd
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


          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
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
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
                  textStyle: GoogleFonts.inriaSans(
                    fontSize:  MediaQuery.of(context).size.width > 350 ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 5,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Discard",
                  textAlign: TextAlign.left,
                )
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
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
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
                  textStyle: GoogleFonts.inriaSans(
                    fontSize:  MediaQuery.of(context).size.width > 350 ? 20 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 5,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                },
                child: Text(
                  "Save",
                  textAlign: TextAlign.left,
                )
            ),
          ),
        ],
      ),
    );
  }
}
