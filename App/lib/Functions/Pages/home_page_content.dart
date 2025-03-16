import 'package:flutter/material.dart';

import '../../Library/libraryHome.dart';
import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';
import '../../Profile/pages/settings_page.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: SizedBox(
            height: 150,
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Text(
                        "Hi User Name,",
                        style: TextStyle(
                          fontSize: 24,
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
                    size: 40,
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
                top: Radius.circular(40.00),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 29.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Scan Options",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Icon(Icons.notification_add),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanSnakesScreen()),
                      );
                    },
                    child: HomepageCard(
                      imgPath: "assets/snake.png",
                      option: "SNAKE SCAN",
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanInsectsScreen()),
                      );
                    },
                    child: HomepageCard(
                      imgPath: "assets/insect.png",
                      option: "INSECTS SCAN",
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanSpidersScreen()),
                      );
                    },
                    child: HomepageCard(
                      imgPath: "assets/spider.png",
                      option: "SPIDER SCAN",
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => libraryHome()),
                          );
                        },
                        child: Container(
                          width: 265,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 4,
                                offset: Offset(4, 4),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xff1C16B9), Color(0xffDC9FDA)],
                            ),
                            borderRadius: BorderRadius.circular(10.00),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "journey to venom world",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 4,
                              offset: Offset(4, 4),
                            ),
                          ],
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.00),
                        ),
                        child: Icon(
                          Icons.wb_twighlight,
                          color: Colors.white,
                          size: 35,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
