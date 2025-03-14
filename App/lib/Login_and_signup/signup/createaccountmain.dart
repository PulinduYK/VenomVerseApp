import 'package:flutter/material.dart';
import 'package:venomverse/Login_and_signup/signup/register/signuppage.dart';

import '../custom page route widget/CustomPageRoute.dart';
import '../login/StarterPage.dart';

class CreateAccountMain extends StatelessWidget {
  const CreateAccountMain({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logo Placeholder
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Logo',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Welcome Text
                                const Text(
                                  'Nice to see you !',
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 70),
                                // Create Account Button
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
                                      elevation:
                                          0, // Disable default button elevation
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()),
                                      );
                                    },
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
                                      child: Container(
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
                                ),
                                const SizedBox(height: 160),
// Row of White Buttons for Google and Phone Login
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Google Button
                                    Container(
                                      width: 120, // Adjust width as needed
                                      height: 60, // Adjust height as needed
                                      decoration: BoxDecoration(
                                        color: Colors.white, // Background color
                                        borderRadius: BorderRadius.circular(
                                            40), // Adjust corner radius
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.15),
                                            offset: Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            ModernPageRoute(
                                                page: const StarterPage()),
                                            (route) =>
                                                false, // Removes all previous routes
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .transparent, // Transparent to keep Container color
                                          shadowColor: Colors
                                              .transparent, // Remove default button shadow
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15), // Matches container for rounded box effect
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.g_mobiledata,
                                                size: 40, color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Phone Button
                                    Container(
                                      width: 120, // Adjust width as needed
                                      height: 60, // Adjust height as needed
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            40), // Adjust corner radius
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.15),
                                            offset: Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle phone login
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.phone,
                                                size: 30, color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
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
