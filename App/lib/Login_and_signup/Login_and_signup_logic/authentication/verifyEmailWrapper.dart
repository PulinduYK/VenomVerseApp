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
          appBar: AppBar(
            title: Text("first You should verify"),
          ),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    sendVerificationEmail();
                  },
                  child: Text("resend email"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                  },
                  child: Text("signout"),
                ),
              ],
            ),
          ),
        );
}
