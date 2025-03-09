import 'package:flutter/material.dart';

import 'home_page_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Heat Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Personal Info"),
        ],
      ),
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
          child: HomePageContent(),
        ),
      ),
    );
  }
}
