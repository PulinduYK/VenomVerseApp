import 'package:flutter/material.dart';
import 'package:venomverse/Functions/Pages/test.dart';

import '../reusable_widgets/homepage_card.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

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
                Text(
                  "Hi! User Name,",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestPage(),
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
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 29.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Scan Options",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Icon(Icons.notification_add),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  HomepageCard(
                    imgPath: "assets/snake.png",
                    option: "Insects Scan",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  HomepageCard(
                    imgPath: "assets/snake.png",
                    option: "Snake Scan",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  HomepageCard(
                    imgPath: "assets/snake.png",
                    option: "Symptoms Scan",
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 280,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff1C16B9), Color(0xffDC9FDA)],
                          ),
                          borderRadius: BorderRadius.circular(30.00),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "journey to venom world",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.00),
                        ),
                        child: Icon(Icons.announcement_rounded),
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
