import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';


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
            onPressed: (){
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "FAQs",
            onPressed: (){
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Customer support",
            onPressed: (){
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Password Management",
            onPressed: (){
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "2-Factor Auth",
            onPressed: (){
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Device Manager",
            onPressed: (){
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: "Privacy Settings",
            onPressed: (){
            },
          ),

        ],
      ),
    );
  }
}