import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/profile_page_template.dart';

// PersonalInfoPage displays the user's personal details.
class HealthMetricsPage extends StatefulWidget {
  const HealthMetricsPage({super.key});

  @override
  State<HealthMetricsPage> createState() => _HealthMetricsPageState();
}

class _HealthMetricsPageState extends State<HealthMetricsPage> {
  String age = '';
  String height = '';
  String weight = '';
  String bmi = '';

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Health Metrics",
        contentHeightFactor: 0.85,
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomTextBox(
                child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "Age:",
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  age,
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )),
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "Height:",
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  height,
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )),
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "Weight:",
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  weight,
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )),
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "BMI:",
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  bmi,
                  style: GoogleFonts.inriaSans(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 350 ? 18 : 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1C16B9), // 0%
                    Color(0xFFDC9FDA), // 100%
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 60),
                    textStyle: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 375 ? 24 : 18,
                      fontWeight: FontWeight.normal,
                    ),
                    elevation: 5,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    ToastPopup.showToast("Not Available");
                  },
                  child: Text(
                    "Edit",
                    textAlign: TextAlign.left,
                  )),
            ),
          ],
        ));
  }
}
