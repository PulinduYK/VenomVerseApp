import 'dart:async';

import 'package:flutter/material.dart';

import '../services/auth.dart';
import 'Homewrapper.dart';

class verifyEmailWrapper extends StatefulWidget {
  const verifyEmailWrapper({super.key});

  @override
  State<verifyEmailWrapper> createState() => _verifyEmailWrapperState();
}

class _verifyEmailWrapperState extends State<verifyEmailWrapper> {
  final AuthServices _auth = AuthServices();
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = _auth.VerifyUser();

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 2),
        (_) => checkEmailVerified(),
      );
    }
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await _auth.reloadUser();
    bool emailVerified = _auth.VerifyUser();
    if (emailVerified) {
      setState(() {
        isEmailVerified = true;
      });
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = _auth.getUser();
      await user.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeWrapper()
      : Scaffold(
          body: Container(
            //height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1C16B9),
                  Color(0xFF6D5FD5),
                  Color(0xFF8A7FD6),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29.0),
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Verification Note",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.question_mark_rounded,
                                size: 40, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40.00),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              clipBehavior: Clip
                                  .hardEdge, // Ensures the image follows the border radius
                              child: Image.asset(
                                'assets/Gmail.png', // Replace with your actual image path
                                fit: BoxFit
                                    .cover, // Adjusts how the image fits inside
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              textAlign: TextAlign.center,
                              "We send an Confirmation email to your email. To Continue open the mail and verify. "
                              "If mail not received click resend email button bellow. Otherwise you can sign "
                              "out and try different email. To sign out click sign out button below",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 40),
                            GestureDetector(
                              onTap: () {
                                sendVerificationEmail();
                              },
                              child: Container(
                                width: 265,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 4,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff8A7FD6),
                                      Color(0xff6D5FD5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10.00),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "resend email",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                _auth.signOut();
                              },
                              child: Container(
                                width: 265,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 4,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff8A7FD6),
                                      Color(0xff6D5FD5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10.00),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "sign out",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
