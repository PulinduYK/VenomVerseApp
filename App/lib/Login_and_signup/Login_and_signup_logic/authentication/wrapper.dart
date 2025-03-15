import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venomverse/Login_and_signup/Login_and_signup_logic/authentication/verifyEmailWrapper.dart';
import 'package:venomverse/Login_and_signup/Login_and_signup_logic/services/auth.dart';

import '../../login/LoginPage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          print(AuthServices().getUser());
          return const verifyEmailWrapper();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
