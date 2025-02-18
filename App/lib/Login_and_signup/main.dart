import 'package:flutter/material.dart';
import 'package:venomverse/Login_and_signup/signup/createaccountmain.dart';
import 'package:venomverse/Login_and_signup/signup/register/signuppage.dart';

import 'login/LoginPage.dart';


// Import your login page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/createAccount': (context) => const CreateAccountMain(),
        '/signUp': (context) => const SignUpPage(),
      },
    );
  }
}
