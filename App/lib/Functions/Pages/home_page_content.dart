import 'package:flutter/material.dart';

import '../../Library/library_home.dart';
import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';
import '../../Profile/pages/settings_page.dart';
import '../Hospital_suggestion/hospital_list.dart';
import '../Menu_pages/scan_insects_screen.dart';
import '../Menu_pages/scan_snakes_screen.dart';
import '../Menu_pages/scan_spiders_screen.dart';
import '../reusable_widgets/homepage_card.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final FirebaseService _firebaseService = FirebaseService();
  String userName = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: SizedBox(
            height: screenHeight * 0.18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<String>(
                  stream: _firebaseService.getUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      userName = snapshot.data ?? "default name";
                      return Text(
                        "Hi ${snapshot.data},", // Displaying the user's name
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Text(
                        "Hi User Name,",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          usernameStream: _firebaseService.getUserName(),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.settings,
                    size: screenWidth * 0.1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(screenWidth * 0.1),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.04,
                    horizontal: screenWidth * 0.08),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Scan Options",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.notification_add),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanSnakesScreen()),
                        );
                      },
                      child: const HomepageCard(
                        imgPath: "assets/snake.png",
                        option: "SNAKE SCAN",
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanInsectsScreen()),
                        );
                      },
                      child: const HomepageCard(
                        imgPath: "assets/insect.png",
                        option: "INSECTS SCAN",
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScanSpidersScreen()),
                        );
                      },
                      child: const HomepageCard(
                        imgPath: "assets/spider.png",
                        option: "SPIDER SCAN",
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LibraryHome()),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 4,
                                  offset: Offset(4, 4),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [Color(0xff8A7FD6), Color(0xff6D5FD5)],
                              ),
                              borderRadius: BorderRadius.circular(30.00),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              child: Text(
                                "Journey to venom world",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HospitalListScreen(), // Navigate to the hospital list
                              ),
                            );
                          },
                          child: Container(
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 4,
                                  offset: Offset(4, 4),
                                ),
                              ],
                              color: const Color(0xFF800000),
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.15 / 2),
                            ),
                            child: Image.asset(
                              'assets/panic.gif',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
