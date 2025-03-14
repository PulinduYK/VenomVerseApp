import 'package:flutter/material.dart';

class libPageCard extends StatelessWidget {
  //final IconData iconData;
  final String option;
  final String imgPath;
  const libPageCard({super.key, required this.option, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(7.0),
              width: 115,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF756EF3),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Image.asset(
                imgPath,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              option,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
