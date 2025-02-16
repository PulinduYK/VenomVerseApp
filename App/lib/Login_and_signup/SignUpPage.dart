import 'package:flutter/material.dart';
import 'birthdaygenderpage.dart';
import 'dart:async';

import 'SetPasswordPage.dart'; // Next page

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isAgreeChecked = false;
  bool _isEmailValid = true;
  bool _isOTPSent = false;
  bool _isOTPVerified = false;
  int _otpCountdown = 60;
  Timer? _timer;
  final String _demoOTP = "123456"; // Hardcoded demo OTP
  bool _isPasswordMatching = true;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool validateEmailExternally(String email) {
    return email.endsWith('@gmail.com');
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Sent Successfully! Check your email.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid Gmail address!")),
      );
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

  void _validatePasswords() {
    setState(() {
      _isPasswordMatching = _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  bool _isFormValid() {
    return _isEmailValid &&
        _isOTPVerified &&
        _isAgreeChecked &&
        _isPasswordMatching &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  void _createAccount() {
    if (_isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => BirthdayGenderPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields correctly.")),
      );
    }
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
        child: Column(
          children: [
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
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
                      "Register",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
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
                        errorText: _isEmailValid ? null : "Enter a valid Gmail address",
                      ),
                    ),
                    const SizedBox(height: 30),
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
                    ElevatedButton(
                      onPressed: _isOTPSent ? _verifyOTP : null,
                      child: const Text("Confirm OTP"),
                    ),
                    if (_isOTPVerified) ...[
                      const SizedBox(height: 20),
                      TextField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (_) => _validatePasswords(),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (_) => _validatePasswords(),
                      ),
                      if (!_isPasswordMatching)
                        const Text(
                          "Passwords do not match!",
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      CheckboxListTile(
                        title: const Text("I agree to the Terms & Conditions"),
                        value: _isAgreeChecked,
                        onChanged: (value) {
                          setState(() {
                            _isAgreeChecked = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isFormValid() ? _createAccount : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: _isFormValid() ? Colors.blue : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Create Account"),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
