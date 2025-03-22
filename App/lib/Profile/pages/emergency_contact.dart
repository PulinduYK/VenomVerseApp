import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// EmergencyContactPage displays the user's emergency contacts.
class EmergencyContactPage extends StatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  State<EmergencyContactPage> createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyContactPage> {
  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Emergency Contacts",
        contentHeightFactor: 0.85,
        child: Column(
          children:[

          ],
        )
    );
  }
}

