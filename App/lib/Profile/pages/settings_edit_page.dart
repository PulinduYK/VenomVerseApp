import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/profile_page_template.dart';

// Settings edit page displays the edit version of the settings page.
class SettingsEditPage extends StatefulWidget {
  const SettingsEditPage({super.key});

  @override
  _SettingsEditPageState createState() => _SettingsEditPageState();
}

class _SettingsEditPageState extends State<SettingsEditPage> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      title: "Settings",
      contentHeightFactor: 0.85,
      child: Column(
        children: [
          const SizedBox(height: 50), // For Space

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
                      : const AssetImage('assets/profile_picture.jpg') as ImageProvider,
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
                            color: Colors.black.withOpacity(0.3),
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
          SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // 85% of screen width
            height: 60,
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                // errorText: !_isUsernameValid && _usernameController.text.isNotEmpty
                //     ? 'Username is required'
                //     : null,
              ),
              // onChanged: (value) {
              //   setState(() {
              //     _isUsernameValid = value.isNotEmpty;
              //   });
              // },
            ),
          ),
        ],
      ),
    );
  }
}
