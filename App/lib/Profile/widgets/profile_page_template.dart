import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Functions/Hospital_suggestion/hospital_list.dart';

// create custom widget to reuse same background template
class ProfilePageTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final double contentHeightFactor;

  const ProfilePageTemplate({
    super.key,
    required this.title,
    required this.child,
    this.contentHeightFactor = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 10,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: MediaQuery.of(context).size.width > 350 ? 26 : 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: GoogleFonts.inriaSans(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width > 350 ? 24 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
        child: FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const HospitalListScreen(), // Navigate to the hospital list
              ),
            );
            //Panic button
          },
          backgroundColor: Colors.transparent,
          child: Container(
            width: 60,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 4,
                  offset: Offset(4, 4),
                ),
              ],
              color: Color(0xFF800000),
            ),
            child: Image.asset('assets/panic.gif', fit: BoxFit.cover),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1C16B9),
                  Color(0xFF6D5FD5),
                  Color(0xFF8A7FD6),
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * contentHeightFactor,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// create custom widget to reuse same button template
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.85,
            MediaQuery.of(context).size.height * 0.075),
        alignment: Alignment.centerLeft,
        textStyle: GoogleFonts.inriaSans(
          fontSize: MediaQuery.of(context).size.width > 350 ? 24 : 18,
          fontWeight: FontWeight.normal,
        ),
        elevation: 5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class CustomTextBox extends StatelessWidget {
  final Widget child;

  const CustomTextBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.075,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: child,
    );
  }
}

class ToastPopup {
  static void showToast(String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: const Color(0xFF8A7FD6),
      textColor: Colors.white,
    );
  }
}
