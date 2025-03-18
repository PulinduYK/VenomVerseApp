import 'package:flutter/material.dart';

import '../Functions/Results_pages/back_button.dart';
import '../Functions/reusable_widgets/libPage_card.dart';
import 'libraryList.dart';

class libraryHome extends StatefulWidget {
  const libraryHome({super.key});

  @override
  State<libraryHome> createState() => _libraryHomeState();
}

class _libraryHomeState extends State<libraryHome> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        //height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1C16B9),
              Color(0xFF6D5FD5),
              Color(0xFF8A7FD6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0),
                child: SizedBox(
                  height: screenHeight * 0.15,
                  child: Row(
                    children: [
                      CustomBackButton(),
                      SizedBox(
                          width: screenWidth * 0.05,
                      ),
                      Text(
                        "Library",
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
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
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.04,
                      horizontal: screenWidth * 0.08,),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                              ),
                            ),
                            Icon(Icons.help),
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
                                  builder: (context) => libraryList(
                                        category: "Snakes",
                                        modelNo: 1,
                                      )),
                            );
                          },
                          child: libPageCard(
                            imgPath: "assets/snake.png",
                            option: "SNAKES LOG",
                          ),
                        ),
                        SizedBox(
                            height: screenHeight * 0.035,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => libraryList(
                                        category: "Insects",
                                        modelNo: 3,
                                      )),
                            );
                          },
                          child: libPageCard(
                            imgPath: "assets/insect.png",
                            option: "INSECTS LOG",
                          ),
                        ),
                        SizedBox(
                            height: screenHeight * 0.035,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => libraryList(
                                        category: "Spiders",
                                        modelNo: 2,
                                      )),
                            );
                          },
                          child: libPageCard(
                            imgPath: "assets/spider.png",
                            option: "SPIDERS LOG",
                          ),
                        ),
                        SizedBox(
                            height: screenHeight * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.6,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 4,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff1C16B9),
                                    Color(0xffDC9FDA)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(60.00),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "CHAT BOT",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
