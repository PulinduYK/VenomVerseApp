import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:venomverse/Functions/Results_pages/reportSection.dart';

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

  String name = "Loading.....";
  String imagePath = "assets/snake.png";
  String lethalityLevel = "Loading.";
  String description = "Loading.....";
  List<String> remedies = ["Loading....."];

  @override
  void initState() {
    super.initState();
    _checkConfidence();
  }

  // Fetch data from Firebase
  void _fetchSnakeData() async {
    await Future.delayed(Duration(seconds: 1));
    int classNo =
        widget.uploadedImageData['prediction']?.toDouble()?.toInt() ?? 0;
    int modelNo =
        widget.uploadedImageData['model_id']?.toDouble()?.toInt() ?? 0;
    String resultName = _outcomeClass.venomClass(modelNo, classNo);

    await _firebaseService.insertHistory(modelNo, true, true, resultName);

    Map<String, dynamic> snakeDetails =
        await _firebaseService.getVenomDetails(modelNo, resultName);
    List<String> fetchedRemedies =
        await _firebaseService.getRemedies(modelNo, resultName);

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

  Future<void> _checkConfidence() async {
    double confidence = widget.uploadedImageData['confidence']?.toDouble() ?? 0;
    int modelNoForHistory =
        widget.uploadedImageData['model_id']?.toDouble()?.toInt() ?? 4;
    confidence = confidence * 100;
    if (confidence < 90) {
      await _firebaseService.insertHistory(
          modelNoForHistory, true, false, "none");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        barrierDismissible: true,
        confirmBtnText: 'Got it',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        confirmBtnColor: Colors.deepPurpleAccent,
        customAsset: 'assets/warning.gif',
        widget: Center(
          child: Column(
            children: [
              Text(
                "Low Accuracy",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Image uploaded Successfully But The accuracy of the detection is low. Please retake the image for better results.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );
    } else {
      _fetchSnakeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: 370,
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),

          // Back Button (Top-Left)
          Positioned(top: 50, left: 15, child: CustomBackButton()),

          // Result Card (Bottom Section)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.67,
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
                      heightFactor: 2,
                      child: Text(
                        "Result",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Snake Name & Lethality Badge
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.75, // Set a fixed width
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Name:- ${name}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              softWrap: true, // Ensures text wraps
                              overflow: TextOverflow
                                  .visible, // Ensures text doesn't get cut off
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LethalityBadge(
                            confidence: lethalityLevel,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    ImmediateActionsSection(actions: remedies),
                    SizedBox(height: 15),

                    // Description Section
                    DescriptionSection(description: description),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: RetakeButton(
                        buttonName: "Generate Report",
                        onPressed: () async {
                          // PermissionStatus status =
                          //     await Permission.notification.request();
                          // if (status.isDenied || status.isPermanentlyDenied) {
                          //   await openAppSettings();
                          // }
                          await PdfReport.generateReport(
                            reportID: "RPT12345",
                            dateTime: "15/03/2025 10:30",
                            location: "7.8731° N, 80.7718° E",
                            userID: "USR56789",
                            userName: 'dude',
                            dob: '209383 -3783 -3883',
                            allergies: 'kjnfskgbdrkrgn',
                            category: "Snake",
                            scientificName: "Naja naja",
                            image:
                                null, // Replace with image bytes if available
                            confidenceScore: 98.5,
                            firstAidActions: [
                              "Keep calm, apply pressure bandage."
                            ],
                            lethalityRisk: "High",
                            deviceModel: 'testing device',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 20, // Pin to the bottom
            child: RetakeButton(
              buttonName: "Retake",
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {},
              shape: const CircleBorder(),
              child: Icon(Icons.wb_twighlight, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
