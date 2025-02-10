import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';


// PersonalInfoPage displays the user's personal details.
class HealthMetricsPage extends StatelessWidget {
  const HealthMetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Health Metrics",
        contentHeightFactor: 0.85,
        child: Column(
          children:[

          ],
        )
    );
  }
}