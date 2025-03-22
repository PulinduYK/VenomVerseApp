import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// ProfilePage displays the user's account details.
class TrackingWearablePage extends StatelessWidget {
  const TrackingWearablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Tracking Wearable",
        contentHeightFactor: 0.85,
        child: Column(
          children:[

          ],
        )
    );
  }
}