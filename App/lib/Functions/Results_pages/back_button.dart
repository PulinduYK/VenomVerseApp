import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
