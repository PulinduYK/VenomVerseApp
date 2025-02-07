import 'package:flutter/material.dart';



class ScanInsectsScreen extends StatelessWidget{
  const ScanInsectsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Scan Insects",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,

            ),

          ),

          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
            onPressed: () => Navigator.of(context).pop(),
          ),


          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors:[
                  Color(0xff1C16B9),
                  Color(0xff6D5FD5),
                  Color(0xff8A7FD6),
                ])

            ),
          ),

        ),
      ),
    );
  }

}