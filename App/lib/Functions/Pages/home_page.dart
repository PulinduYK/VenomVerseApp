import 'package:flutter/material.dart';

import '../../History/history_page.dart';
import '../Heat Map/google_map_screen.dart';
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
    const HomePageContent(),
    const HistoryPage(),
    const GoogleMapScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Navigate to GoogleMapScreen instead of switching tabs
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GoogleMapScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index; // Update the selected tab normally
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Map"),
        ],
      ),
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
          child: IndexedStack(
            index: _selectedIndex, // Keeps state of each page
            children: _pages,
          ),
        ),
      ),
    );
  }
}
