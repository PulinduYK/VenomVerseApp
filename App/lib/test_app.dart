import 'package:flutter/material.dart';
// Import your normal app components but not the Firebase initialization

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a version of your app that doesn't require Firebase
    // This could be just the main widget tree without the Firebase initializations
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('0'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
