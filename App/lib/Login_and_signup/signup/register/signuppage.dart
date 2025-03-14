import 'package:flutter/material.dart';
import 'package:venomverse/Login_and_signup/Login_and_signup_logic/services/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isAgreeChecked = false;
  bool _isEmailValid = true;
  bool _isPasswordValid = false;
  bool _doPasswordsMatch = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$").hasMatch(email);
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.length >= 6 && password.length <= 12;
    });
  }

  void _validateConfirmPassword(String confirmPassword) {
    setState(() {
      _doPasswordsMatch = confirmPassword == _passwordController.text;
    });
  }

  void _showTermsAndConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Conditions"),
          content: const SingleChildScrollView(
            child:
                Text("app on testing mode haven't any terms and conditions ."),
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
    var screenWidth = MediaQuery.of(context).size.width;
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 50.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: screenWidth > 600 ? 500 : double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 30),
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
                              const SizedBox(height: 60),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorText: _isEmailValid
                                      ? null
                                      : "Invalid email. Must end with @gmail.com",
                                ),
                                onChanged: _validateEmail,
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password (8-12 characters)',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorText: _isPasswordValid
                                      ? null
                                      : "Password must be between 6 and 12 characters.",
                                ),
                                onChanged: _validatePassword,
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  errorText: _doPasswordsMatch
                                      ? null
                                      : "Passwords do not match",
                                ),
                                onChanged: _validateConfirmPassword,
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
                              const SizedBox(height: 35),
                              ElevatedButton(
                                onPressed: (_isEmailValid &&
                                        _isPasswordValid &&
                                        _doPasswordsMatch &&
                                        _isAgreeChecked)
                                    ? () async {
                                        await _auth
                                            .createUserWithEmailAndPassword(
                                                _emailController.text,
                                                _confirmPasswordController
                                                    .text);
                                        if (mounted) {
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // Remove default padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // Match design
                                  ),
                                  elevation: 5, // Optional: Adds shadow effect
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF1C16B9),
                                        Color(0xFF6D5FD5),
                                        Color(0xFF8A7FD6),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        30), // Same as button shape
                                  ),
                                  child: Container(
                                    width: double
                                        .infinity, // Makes button full width
                                    height: 55, // Adjust height
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
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
