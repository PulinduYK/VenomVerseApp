import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reset link sent to $email")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your email to receive a password reset link.",
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
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 20),

            // Send Reset Link Button
            ElevatedButton(
              onPressed: sendResetEmail,
              child: const Text("Send Reset Link"),
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
                child: const Text("Back to Login"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
