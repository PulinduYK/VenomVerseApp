import 'package:flutter/material.dart';
import 'package:venomverse/Profile/pages/health_metrics_page.dart';
import 'package:venomverse/Profile/pages/medical_info_page.dart';
import 'package:venomverse/Profile/pages/personal_info_page.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// ProfilePage displays the user's account details.
class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Account details",
        contentHeightFactor: 0.85,
        child: Column(
          children:[
            SizedBox(height: 50),
            CustomButton(
              text: "Personal info",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Tracking Wearable",
              onPressed: () {
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Medical Info",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalInfoPage()),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Health Metrics",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HealthMetricsPage()),
                );
              },
            ),
          ],
        ));
  }
}
