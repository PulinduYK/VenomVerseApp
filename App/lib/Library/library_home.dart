import 'package:flutter/material.dart';

import '../../Functions/Hospital_suggestion/hospital_list.dart';
import '../Functions/Results_pages/back_button.dart';
import '../Functions/reusable_widgets/lib_page_card.dart';
import 'library_list.dart';

class LibraryHome extends StatefulWidget {
  const LibraryHome({super.key});

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        //height: double.infinity,
        decoration: const BoxDecoration(
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
                      const CustomBackButton(),
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.00),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.04,
                      horizontal: screenWidth * 0.08,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(Icons.help),
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
                                  builder: (context) => const LibraryList(
                                        category: "Snakes",
                                        modelNo: 1,
                                      )),
                            );
                          },
                          child: const LibPageCard(
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
                                  builder: (context) => const LibraryList(
                                        category: "Insects",
                                        modelNo: 3,
                                      )),
                            );
                          },
                          child: const LibPageCard(
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
                                  builder: (context) => const LibraryList(
                                        category: "Spiders",
                                        modelNo: 2,
                                      )),
                            );
                          },
                          child: const LibPageCard(
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
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 4,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff8A7FD6),
                                    Color(0xff6D5FD5),
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
                                  borderRadius: BorderRadius.circular(
                                      screenWidth * 0.15 / 2),
                                ),
                                child: Image.asset(
                                  'assets/panic.gif',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
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
