import 'package:flutter/material.dart';

class HomepageCard extends StatelessWidget {
  //final IconData iconData;
  final String option;
  final String imgPath;
  const HomepageCard({super.key, required this.option, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF756EF3),
                borderRadius: BorderRadius.circular(15),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
