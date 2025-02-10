import 'package:flutter/material.dart';
import 'package:venomverse/Profile/pages/account_details_page.dart';
import 'package:venomverse/Profile/pages/help_page.dart';
import 'package:venomverse/Profile/pages/history_page.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';


// SettingsPage displays the settings details.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Settings",
        contentHeightFactor: 0.85,
        child: Column(
          children:[
                SizedBox(height: 20),// For Space
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9D9D9), // Placeholder color for the profile pic
                  ),
                ),
                SizedBox(height: 20), // For Space
                Text(
                  "John Collins", // Text for name
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:  MediaQuery.of(context).size.width > 375 ? 24 : 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inria Sans',
                  ),
                ),
                Text(
                  "@john_collins", // Text for username
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:  MediaQuery.of(context).size.width > 375 ? 14 : 10,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inria Sans',
                  ),
                ),
                SizedBox(height: 20), // For Space
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width * 0.35, 60),
                          textStyle: TextStyle(
                              fontSize:  MediaQuery.of(context).size.width > 375 ? 24 : 18,
                              fontWeight: FontWeight.bold
                          ),
                          elevation: 5,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {

                        },
                        child: Text(
                          "Edit",
                        )
                    ),
                    SizedBox(width: 10), // For Space between buttons
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(60, 60),
                          maximumSize: Size(60, 60),
                          textStyle: TextStyle(
                              fontSize:  MediaQuery.of(context).size.width > 375 ? 24 : 18,
                              fontWeight: FontWeight.bold
                          ),
                          elevation: 5,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                        },
                        child: Text(
                          "+",

                        )
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CustomButton(
                  text: "Account details",
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountDetailsPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: "Security and Help",
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: "History",
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                // create Container for add that gradient effect
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1C16B9), // 0%
                          Color(0xFF6D5FD5), // 50%
                          Color(0xFF8A7FD6), // 100%
                        ],
                        stops: [0.0, 0.5, 1.0], // Gradient stops
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,

                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 5),
                          blurRadius: 10,

                        ),
                      ],
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 60),
                        textStyle: TextStyle(
                          fontSize:  MediaQuery.of(context).size.width > 375 ? 24 : 18,
                          fontWeight: FontWeight.normal,
                        ),
                        elevation: 5,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        "Log out",
                        textAlign: TextAlign.left,
                      )
                  ),
                ),
              ],
            ),
    );
  }
}
