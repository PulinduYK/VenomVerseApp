import 'package:flutter/material.dart';
import 'dart:async';

import 'SetPasswordPage.dart'; // Next page

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isAgreeChecked = false;
  bool _isEmailValid = true;
  bool _isUsernameValid = true;
  bool _isOTPSent = false;
  bool _isOTPVerified = false;
  int _otpCountdown = 60;
  Timer? _timer;
  final String _demoOTP = "123456"; // Hardcoded demo OTP

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool validateEmailExternally(String email) {
    return email.endsWith('@gmail.com');
  }

  bool _isFormValid() {
    return _isUsernameValid && _isEmailValid && _isOTPVerified && _isAgreeChecked;
  }

  void _startOTPTimer() {
    setState(() {
      _otpCountdown = 60;
      _isOTPSent = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpCountdown > 0) {
        setState(() {
          _otpCountdown--;
        });
      } else {
        setState(() {
          _isOTPSent = false; // Allow resend
        });
        timer.cancel();
      }
    });
  }

  void _sendOTP() {
    setState(() {
      _isEmailValid = validateEmailExternally(_emailController.text);
    });

    if (_isEmailValid) {
      _startOTPTimer();
    }
  }

  void _verifyOTP() {
    setState(() {
      _isOTPVerified = _otpController.text == _demoOTP;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_isOTPVerified ? "OTP Verified Successfully!" : "Invalid OTP. Try again!")),
    );
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Conditions"),
          content: const SingleChildScrollView(
            child: Text(
              "I love you"
                  ,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF1C16B9),
              Color(0xFF6D5FD5),
              Color(0xFF8A7FD6),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Create an Account',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 40),
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email (@gmail.com)',
                                  prefixIcon: const Icon(Icons.email),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.send, color: Colors.blue),
                                    onPressed: _sendOTP,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (_isOTPSent)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _otpCountdown > 0
                                          ? "Resend OTP in $_otpCountdown sec"
                                          : "Didn't receive OTP?",
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                    if (_otpCountdown == 0)
                                      TextButton(
                                        onPressed: _sendOTP,
                                        child: const Text("Resend OTP", style: TextStyle(color: Colors.blue)),
                                      ),
                                  ],
                                ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: _otpController,
                                decoration: InputDecoration(
                                  hintText: 'Enter OTP',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _isOTPSent ? _verifyOTP : null,
                                child: const Text("Confirm OTP"),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isAgreeChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAgreeChecked = value!;
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: _showTermsAndConditions,
                                    child: const Text(
                                      'I agree to the Terms and Conditions',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _isFormValid()
                                    ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SetPasswordPage(email: '', phoneNumber: '',),
                                    ),
                                  );
                                }
                                    : null,
                                child: const Text("Create Account"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
