import 'package:flutter/material.dart';


import 'birthdaygenderpage.dart';

class SetPasswordPage extends StatefulWidget {
  final String email;
  final String phoneNumber;

  const SetPasswordPage({super.key, required this.email, required this.phoneNumber});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _passwordStrength = 'Weak';
  bool _isPasswordMatching = true;

  // Function to check password strength
  void _checkPasswordStrength(String password) {
    if (password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      setState(() {
        _passwordStrength = 'Strong';
      });
    } else if (password.length >= 6 &&
        RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password)) {
      setState(() {
        _passwordStrength = 'Medium';
      });
    } else {
      setState(() {
        _passwordStrength = 'Weak';
      });
    }
  }

  // Function to validate password matching
  void _validatePasswordMatching() {
    setState(() {
      _isPasswordMatching = _newPasswordController.text == _confirmPasswordController.text;
    });
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
            return ConstrainedBox(
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
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
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
                              'Set Your Password',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 40),
                            // New Password Field
                            TextField(
                              controller: _newPasswordController,
                              obscureText: true,
                              onChanged: (value) {
                                _checkPasswordStrength(value);
                                _validatePasswordMatching();
                              },
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                prefixIcon: const Icon(Icons.lock),
                                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Password Strength: $_passwordStrength',
                              style: TextStyle(
                                fontSize: 12,
                                color: _passwordStrength == 'Strong'
                                    ? Colors.green
                                    : _passwordStrength == 'Medium'
                                    ? Colors.orange
                                    : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Confirm Password Field
                            TextField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              onChanged: (_) => _validatePasswordMatching(),
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock),
                                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorText: !_isPasswordMatching &&
                                    _confirmPasswordController.text.isNotEmpty
                                    ? 'Passwords do not match'
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Continue Button
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
                                ),
                                onPressed: _isPasswordMatching &&
                                    _passwordStrength != 'Weak' &&
                                    _newPasswordController.text.isNotEmpty
                                    ? () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BirthdayGenderPage(),
                                    ),
                                  );
                                }
                                    : null,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF1C16B9),
                                        Color(0xFF6D5FD5),
                                        Color(0xFF8A7FD6),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(
                                        fontSize: 20,
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
            );
          },
        ),
      ),
    );
  }
}
