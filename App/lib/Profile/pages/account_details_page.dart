import 'package:flutter/material.dart';
import 'package:venomverse/Profile/pages/health_metrics_page.dart';
import 'package:venomverse/Profile/pages/medical_info_page.dart';
import 'package:venomverse/Profile/pages/personal_info_page.dart';
import 'package:venomverse/Profile/pages/tracking_wearable_page.dart';
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
          children: [
            const SizedBox(height: 50),
            CustomButton(
              text: "Personal info",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalInfoPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Tracking Wearable",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrackingWearablePage()),
                );
                ToastPopup.showToast(
                    "Coming Soon! This feature will be available in a future update.");
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Medical Info",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MedicalInfoPage()),
                );
                ToastPopup.showToast(
                    "Coming Soon! This feature will be available in a future update.");
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Health Metrics",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HealthMetricsPage()),
                );
                ToastPopup.showToast(
                    "Coming Soon! This feature will be available in a future update.");
              },
            ),
          ],
        ));
  }
}
