import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String? userEmail;
  bool isResetSent = false;

  @override
  void initState() {
    super.initState();
    detectUserEmail();
  }

  // Detect if Firebase remembers the user's email
  void detectUserEmail() {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    if (currentUserEmail != null) {
      setState(() {
        userEmail = currentUserEmail;
        _emailController.text = userEmail!;
      });
    }
  }

  // Send password reset email
  Future<void> sendResetEmail() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email.")),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        isResetSent = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Reset link sent to $email")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style: TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
          ),
        ),
        centerTitle: false, // Aligns the title to the left
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your email to receive a link to reset your password .",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Email input field (disabled if email is detected)
            TextField(
              controller: _emailController,
              enabled: userEmail == null, // Disable if email is detected
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  // Rounded when not focused
                  borderSide: const BorderSide(
                      color: Colors.grey), // Default border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  // Rounded when focused
                  borderSide: const BorderSide(
                      color: Colors.blue), // Border color on focus
                ),
                prefixIcon: const Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 20),

            // Send Reset Link Button
            ElevatedButton(
              onPressed: sendResetEmail,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                backgroundColor: Colors.transparent,
                // Makes the button background transparent
                shadowColor: Colors.transparent, // Keeps shadow consistent
              ).merge(
                ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  // No overlay effect
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      // Gradient background on press
                      return Colors.transparent;
                    },
                  ),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff8A7FD6), // Left color
                      Color(0xff6D5FD5), // Right color
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints:
                      const BoxConstraints(minWidth: 200, minHeight: 50),
                  child: const Text(
                    "Send Reset Link",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            if (isResetSent) ...[
              const SizedBox(height: 20),
              const Text(
                "After resetting your password, click the button below to return to the login page.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to login
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  backgroundColor:
                      Colors.transparent, // Transparent to show gradient
                  shadowColor: Colors.transparent, // Keeps shadow consistent
                ).merge(
                  ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                        Colors.transparent), // No overlay effect
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        return Colors.transparent; // Gradient stays on press
                      },
                    ),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff8A7FD6), // Left gradient color
                        Color(0xff6D5FD5), // Right gradient color
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(30), // Match button corners
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                        minWidth: 200, minHeight: 50), // Button size
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
