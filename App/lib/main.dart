import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Center(
              child: Text(
                "Test appbar",
                style: TextStyle(fontSize: 30),
              ),
            ),
            leading: Icon(
              Icons.camera,
              size: 50,
            ),
            actions: [
              Icon(
                Icons.menu,
                size: 50,
              )
            ],
            backgroundColor: Colors.red),
      ),
    );
  }
}
