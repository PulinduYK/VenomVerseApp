//test
import 'package:flutter/material.dart';
class ScanInsectsScreen extends StatelessWidget{
  const ScanInsectsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff1C16B9),
                    Color(0xff6D5FD5),
                    Color(0xff8A7FD6),
                  ]
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0,left: 22),
              child: Text(
                "Scan Insects",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration:BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight:Radius.circular(40) ,
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0,4),
                          )
                        ]
                    ),
                    child: Container(
                      padding:EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInstructionStep(1, "Choose Your Scan Method",
                              "Take a live photo or upload existing or via text."),
                          const SizedBox(height: 20),
                          _buildInstructionStep(2, "Identify the Insect",
                              "Press the 'Scan' button to begin processing."),
                          const SizedBox(height: 20),
                          _buildInstructionStep(3, "View the results",
                              "App will display the insect's details, possible species, and recommendations."),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        _buildGradientButton("Scan Now", () {}),
                        const SizedBox(height: 20),
                        _buildGradientButton("Upload Image", () {

                        }),
                        const SizedBox(height: 20),
                        _buildGradientButton("Via Text", () {

                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      width: 380,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1C16B9),
            Color(0xFFDC9FDA),

          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }



  Widget _buildInstructionStep(int number, String title, String subtitle) {
    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(

          backgroundColor: Colors.purple[300],
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }




}
