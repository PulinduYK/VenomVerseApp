import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// PasswordManagerPage displays the user's password details.
class PasswordManagerPage extends StatelessWidget {
  const PasswordManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Password Manager",
        contentHeightFactor: 0.85,
        child: Column(
          children:[

          ],
        )
    );
  }
}

