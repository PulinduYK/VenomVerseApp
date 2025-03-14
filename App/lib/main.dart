import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:venomverse/Login_and_signup/Login_and_signup_logic/authentication/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD67Z9a_EdUwckQh4Pg7EwPJnG2jB2XR6g",
            authDomain: "venomverse-baaf2.firebaseapp.com",
            projectId: "venomverse-baaf2",
            storageBucket: "venomverse-baaf2.firebasestorage.app",
            messagingSenderId: "997958809242",
            appId: "1:997958809242:web:c3300006dd3fdc8dd1d123"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
