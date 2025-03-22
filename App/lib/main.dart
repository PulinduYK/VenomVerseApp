import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:venomverse/Login_and_signup/Login_and_signup_logic/authentication/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Skip Firebase initialization in test mode
  if (Platform.environment['FIREBASE_SKIP'] != '1') {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
