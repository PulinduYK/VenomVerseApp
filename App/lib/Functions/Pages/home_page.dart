import 'package:flutter/material.dart';

import '../../History/historyPage.dart';
import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Tracks the selected tab

  // List of pages to switch between
  final List<Widget> _pages = [
    HomePageContent(),
    HistoryPage(),
    Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
          child: IndexedStack(
            index: _selectedIndex, // Keeps state of each page
            children: _pages,
          ),
        ),
      ),
    );
  }
}
