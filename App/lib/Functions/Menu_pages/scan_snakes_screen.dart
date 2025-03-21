import 'dart:io';

import 'package:flutter/material.dart';

import '../Camera/camMethodClass.dart';
import '../Camera/camPage.dart';
import '../Hospital_suggestion/hospital_list.dart';
import '../Results_pages/back_button.dart';
import '../scan/gallery.dart';

class ScanSnakesScreen extends StatelessWidget {
  ScanSnakesScreen({super.key});
  final camMethodClass camM = camMethodClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1C16B9),
                  Color(0xff6D5FD5),
                  Color(0xff8A7FD6),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 70),
              child: Text(
                "Scan Snakes",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // White Content Section
          Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffB7AEF3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInstructionStep(
                            1,
                            "Choose Your Scan Method",
                            "Take a live photo or upload existing or via text.",
                          ),
                          const SizedBox(height: 10),
                          _buildInstructionStep(
                            2,
                            "Identify the Insect",
                            "Press the 'Scan' button to begin processing.",
                          ),
                          const SizedBox(height: 20),
                          _buildInstructionStep(
                            3,
                            "View the results",
                            "App will display the insect's details, possible species, and recommendations.",
                          ),
                          const SizedBox(height: 20),
                          _buildInstructionStep(
                            4,
                            "Click panic button for emergencies",
                            "App will display the nearest hospitals.",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Buttons Section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Column(
                        children: [
                          _buildGradientButton("Scan Now", () async {
                            File? pickedFile = await camM.pickImage(context);
                            if (pickedFile != null) {
                              // Navigate to ImageCapture with the selected image
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CamPage(
                                    modelNum: 1,
                                    imageFile: pickedFile,
                                  ),
                                ),
                              );
                            }
                          }),
                          const SizedBox(height: 20),
                          _buildGradientButton("Upload Image", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UploadImagesPage(modelNum: 1),
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          _buildGradientButton("Via Text", () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(top: 54, left: 20, child: CustomBackButton()),

          // Panic Button at Bottom Right
          Positioned(
            bottom: 20,
            right: 20,
            child: _buildPanicButton(context),
          ),
        ],
      ),
    );
  }

  // Gradient Button
  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      width: 380,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff8A7FD6),
            Color(0xff6D5FD5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPanicButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HospitalListScreen(), // Navigate to the hospital list
          ),
        );
      },
      child: Container(
        width: 60,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF800000),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/panic.gif',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Instruction Step Widget
  Widget _buildInstructionStep(int number, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor:Color(0xff8A7FD6),
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
