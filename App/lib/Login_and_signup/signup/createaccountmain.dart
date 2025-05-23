import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:venomverse/Login_and_signup/signup/register/signuppage.dart';

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
                      const SizedBox(height: 170),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15.0, vertical: 50.0),
                      //   child: Row(
                      //     children: [
                      //       IconButton(
                      //         onPressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //         icon: const Icon(Icons.arrow_back,
                      //             color: Colors.white),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          width: screenWidth > 600 ? 500 : double.infinity,
                          //height: double.infinity,
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
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  clipBehavior: Clip
                                      .hardEdge, // Ensures the image follows the border radius
                                  child: Image.asset(
                                    'assets/playstore.png', // Replace with your actual image path
                                    fit: BoxFit
                                        .cover, // Adjusts how the image fits inside
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Welcome Text
                                const Text(
                                  'Nice to see you !',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                const Text(
                                  textAlign: TextAlign.center,
                                  "You're few steps away from our app",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                // Create Account Button
                                Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(),
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
                                const SizedBox(height: 80),
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
                                            color: Colors.black.withValues(),
                                            offset: const Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.custom,
                                            barrierDismissible: true,
                                            confirmBtnText: 'Got it',
                                            confirmBtnColor:
                                                Colors.deepPurpleAccent,
                                            customAsset: 'assets/warning.gif',
                                            widget: const Center(
                                              child: Text(
                                                "Sorry this sign in method currently not available",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
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
                                        child: const Row(
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
                                            color: Colors.black.withValues(),
                                            offset: const Offset(0, 4),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.custom,
                                            barrierDismissible: true,
                                            confirmBtnText: 'Got it',
                                            confirmBtnColor:
                                                Colors.deepPurpleAccent,
                                            customAsset: 'assets/warning.gif',
                                            widget: const Center(
                                              child: Text(
                                                "Sorry this sign in method currently not available",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: const Row(
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
