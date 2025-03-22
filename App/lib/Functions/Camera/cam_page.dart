import 'dart:io';

import 'package:flutter/material.dart';

import 'cam_page_content.dart';

class CamPage extends StatefulWidget {
  final File? imageFile;
  final int modelNum;
  const CamPage({super.key, this.imageFile, required this.modelNum});

  @override
  State<CamPage> createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: CamPageContent(
              modelNum: widget.modelNum, imageFile: widget.imageFile),
        ),
      ),
    );
  }
}
