import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Goes back to the previous screen
                },
                child: const Text("Go Back"),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text("This is home"),
            ],
          ),
        ),
      ),
    );
  }
}
