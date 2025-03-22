import 'package:flutter/material.dart';
import 'package:venomverse/Profile/pages/customer_support_page.dart';
import 'package:venomverse/Profile/pages/device_manager_page.dart';
import 'package:venomverse/Profile/pages/faq_page.dart';
import 'package:venomverse/Profile/pages/password_manager_page.dart';
import 'package:venomverse/Profile/pages/privacy_settings_page.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';
import 'package:venomverse/Profile/pages/emergency_contact.dart';


// HelpPage displays the help details.
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
      title: "Security and Help",
      contentHeightFactor: 0.85,
      child: Column(
        children:[
          SizedBox(height: 50),
          CustomButton(
            text: "Emergency Contact",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmergencyContactPage()),
              );
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "FAQs",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FAQPage()),
              );
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Customer Support",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerSupportPage()),
              );
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Password Manager",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PasswordManagerPage()),
              );
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "2-Factor Auth",
            onPressed: () {
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Device Manager",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeviceManagerPage()),
              );
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Privacy Settings",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PrivacySettingsPage()),
              );
              ToastPopup.showToast("Coming Soon! This feature will be available in a future update.");
            },
          ),

        ],
      ),
    );
  }
}