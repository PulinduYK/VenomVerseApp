import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// FAQPage displays the user's account details.
class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePageTemplate(
        title: "FAQs",
        contentHeightFactor: 0.85,
        child: Column(
          children: [],
        ));
  }
}
