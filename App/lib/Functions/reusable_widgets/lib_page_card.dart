import 'package:flutter/material.dart';

class LibPageCard extends StatelessWidget {
  //final IconData iconData;
  final String option;
  final String imgPath;
  const LibPageCard({super.key, required this.option, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.15),
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
              padding: EdgeInsets.all(screenWidth * 0.02),
              width: screenWidth * 0.3,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF756EF3),
                borderRadius: BorderRadius.circular(screenWidth * 0.15),
              ),
              child: Image.asset(
                imgPath,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
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
