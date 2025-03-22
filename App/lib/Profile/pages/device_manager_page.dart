import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';

// DeviceManagerPage displays the user's device details.
class DeviceManagerPage extends StatelessWidget {
  const DeviceManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePageTemplate(
        title: "Device Manager",
        contentHeightFactor: 0.85,
        child: Column(
          children: [],
        ));
  }
}
