import 'dart:io';

import 'package:flutter/material.dart';

import '../Results_pages/back_button.dart';
import 'camMethodClass.dart';

class CamPageContent extends StatefulWidget {
  final File? imageFile;
  final int modelNum;

  const CamPageContent({super.key, required this.modelNum, this.imageFile});

  @override
  State<CamPageContent> createState() => _CamPageContentState();
}

class _CamPageContentState extends State<CamPageContent> {
  final camMethodClass camM = camMethodClass();
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 20,
                child: CustomBackButton(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.00),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else if (_imageFile != null) ...[
                  Stack(
                    children: [
                      Text(
                        "sometime showing image take little longer. it depends on system performance be patient",
                        textAlign: TextAlign.center,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the value as needed
                        child: Image.file(_imageFile!),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      File? cropped = await camM.cropImage(_imageFile!);
                      setState(() => _imageFile = cropped);
                    },
                    child: Container(
                      width: 265,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xff8A7FD6),
                            Color(0xff6D5FD5),],
                        ),
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() => _isLoading = true);
                      await camM.sendImageToServer(
                          _imageFile!, widget.modelNum, context);
                      setState(() {
                        _imageFile = null;
                        _isLoading = false;
                      });
                    },
                    child: Container(
                      width: 265,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xff8A7FD6),
                            Color(0xff6D5FD5),],
                        ),
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Upload",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Text("Once you click upload image getting Reset"),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      File? pickedFile = await camM.pickImage(context);
                      if (pickedFile != null) {
                        setState(() {
                          _imageFile = pickedFile;
                        });
                      }
                    },
                    child: Container(
                      width: 265,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xff8A7FD6),
                            Color(0xff6D5FD5),],
                        ),
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Retake another image",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
