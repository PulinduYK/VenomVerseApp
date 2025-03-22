import 'package:flutter/material.dart';

class HomepageCard extends StatelessWidget {
  //final IconData iconData;
  final String option;
  final String imgPath;
  const HomepageCard({super.key, required this.option, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7.0),
              width: screenWidth * 0.25,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF756EF3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                imgPath,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.06,
            ),
            Text(
              option,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
