import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// PrivacySettingsPage displays the user's privacy settings.
class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Privacy Settings",
        contentHeightFactor: 0.85,
        child: Column(
          children:[

          ],
        )
    );
  }
}

