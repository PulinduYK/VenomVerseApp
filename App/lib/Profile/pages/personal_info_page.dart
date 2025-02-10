import 'package:flutter/material.dart';
import 'package:venomverse/Profile/widgets/profile_page_template.dart';


// PersonalInfoPage displays the user's personal details.
class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageTemplate(
        title: "Personal Info",
        contentHeightFactor: 0.85,
        child: Column(
          children:[
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Date of Birth:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 24 : 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "2000/02/28",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 20 : 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                  ],
                )
              ),
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Gender:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 24 : 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Male",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 20 : 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Phone Number:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 20: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "+94 75 000 2012",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 20 : 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20),
            CustomTextBox(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Email:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 24 : 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "johncollins@gmail.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width > 375 ? 20 : 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Inria Sans',
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20),
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
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 60),
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
                    "Edit",
                    textAlign: TextAlign.left,
                  )
              ),
            ),
          ],
        )
    );
  }
}

