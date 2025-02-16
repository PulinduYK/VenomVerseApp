import 'package:flutter/material.dart';
import 'CreateAccountPnumber.dart'; // Next page

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

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // External email validation function (Pulindu can implement this with Firebase)
  bool validateEmailExternally(String email) {
    return email.endsWith('@gmail.com');
  }

  // Check if the form is valid
  bool _isFormValid() {
    return _isUsernameValid && _isEmailValid && _otpController.text.isNotEmpty && _isAgreeChecked;
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
                              // Username Field
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  prefixIcon: const Icon(Icons.person),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorText: !_isUsernameValid && _usernameController.text.isNotEmpty
                                      ? 'Username is required'
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _isUsernameValid = value.isNotEmpty;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              // Email Field
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email (@gmail.com)',
                                  prefixIcon: const Icon(Icons.email),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorText: !_isEmailValid && _emailController.text.isNotEmpty
                                      ? 'Invalid email. Must end with @gmail.com'
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _isEmailValid = validateEmailExternally(value);
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              // OTP Field
                              TextField(
                                controller: _otpController,
                                decoration: InputDecoration(
                                  hintText: 'Enter OTP',
                                  prefixIcon: const Icon(Icons.lock),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Checkbox for terms and conditions
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
                                  const Text('I agree to the terms and conditions'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Create Account Button with Gradient
                              Container(
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      offset: const Offset(0, 5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.all(0),
                                    elevation: 0,
                                    backgroundColor: _isFormValid()
                                        ? const Color(0xFF1C16B9)
                                        : Colors.grey,
                                  ),
                                  onPressed: _isFormValid()
                                      ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CreateAccountPnumber(),
                                      ),
                                    );
                                  }
                                      : null,
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: _isFormValid()
                                          ? const LinearGradient(
                                        colors: [
                                          Color(0xFF1C16B9),
                                          Color(0xFF6D5FD5),
                                          Color(0xFF8A7FD6),
                                        ],
                                      )
                                          : const LinearGradient(
                                        colors: [Colors.grey, Colors.grey],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
