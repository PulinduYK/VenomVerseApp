import 'package:flutter/material.dart';

import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';
import 'back_button.dart';
import 'description_section.dart';
import 'immediate_actions.dart';
import 'lethality_badge.dart';
import 'outcomeClass.dart';
import 'retake_button.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> uploadedImageData;

  const ResultScreen({
    super.key,
    required this.uploadedImageData,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final outcomeClass _outcomeClass = outcomeClass();

  String name = "";
  String imagePath = "assets/snake.png";
  String lethalityLevel = "";
  String description = "";
  List<String> remedies = [];

  @override
  void initState() {
    super.initState();
    _fetchSnakeData();
  }

  // Fetch data from Firebase
  void _fetchSnakeData() async {
    int classNumber =
        widget.uploadedImageData['prediction']?.toDouble()?.toInt() ?? 0;
    String resultName = _outcomeClass.snakeClass(classNumber);

    Map<String, dynamic> snakeDetails =
        await _firebaseService.getSnakeDetails(resultName);
    List<String> fetchedRemedies =
        await _firebaseService.getRemedies(resultName);

    setState(() {
      name = snakeDetails['name'] ?? 'Unknown';
      imagePath = snakeDetails['imagePath']?.isNotEmpty == true
          ? snakeDetails['imagePath']
          : 'assets/snake.png';
      lethalityLevel = snakeDetails['lethalityLevel'] ?? 'Unknown';
      description = snakeDetails['description'] ?? 'Unknown';
      remedies = fetchedRemedies;
    });
  }

  String getLethalityLevel() {
    if (lethalityLevel == "None") return "None";
    if (lethalityLevel == "Low") return "Low";
    if (lethalityLevel == "Medium") return "Medium";
    if (lethalityLevel == "High") return "High";
    return "Not Specified";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),

          // Back Button
          Positioned(top: 40, left: 10, child: CustomBackButton()),

          // Result Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Result Title
                    Center(
                      child: Text(
                        "Result",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Snake Name & Lethality Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        LethalityBadge(
                            confidence: getLethalityLevel(),
                            confidenceTxt: lethalityLevel),
                      ],
                    ),

                    SizedBox(height: 15),

                    // Immediate Actions (Header + Bullet Points)
                    ImmediateActionsSection(actions: remedies),
                    SizedBox(height: 15),

                    // Description Section
                    DescriptionSection(description: description),

                    SizedBox(height: 15),

                    // Retake & Emergency Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RetakeButton(),
                        FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {},
                          child: Icon(Icons.emergency, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
