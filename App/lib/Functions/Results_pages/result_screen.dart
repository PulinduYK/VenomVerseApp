import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:venomverse/Functions/Results_pages/reportSection.dart';
import '../../Functions/Hospital_suggestion/hospital_list.dart';
import '../../Functions/Hospital_suggestion/hospital_list.dart';

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

  String userMailForPdf = "venomversese91@gmail.com";
  String userId = "not available";
  String userName = "not available";
  String dob = "not available";
  String allergies = "not available";
  String category = "not specified";
  String name = "Loading.....";
  String imagePath = "assets/snake.png";
  String lethalityLevel = "Loading.";
  String description = "Loading.....";
  List<String> remedies = ["Loading....."];
  double finalConfidence = 0;

  @override
  void initState() {
    super.initState();
    _checkConfidence();
  }

  // Fetch data from Firebase
  void _fetchSnakeData() async {
    await Future.delayed(Duration(seconds: 1));
    String categoryName;
    int classNo =
        widget.uploadedImageData['prediction']?.toDouble()?.toInt() ?? 0;
    int modelNo =
        widget.uploadedImageData['model_id']?.toDouble()?.toInt() ?? 0;
    String resultName = _outcomeClass.venomClass(modelNo, classNo);
    double imageDataConfidence =
        widget.uploadedImageData['confidence']?.toDouble() ?? 0;

    await _firebaseService.insertHistory(modelNo, true, true, resultName);

    Map<String, dynamic> snakeDetails =
        await _firebaseService.getVenomDetails(modelNo, resultName);
    List<String> fetchedRemedies =
        await _firebaseService.getRemedies(modelNo, resultName);
    Map<String, dynamic> userData = await _firebaseService.getUserData();
    if (modelNo == 1) {
      categoryName = "Snake";
    } else if (modelNo == 2) {
      categoryName = "Spider";
    } else if (modelNo == 3) {
      categoryName = "Insects";
    } else {
      categoryName = "not-specified";
    }

    setState(() {
      userMailForPdf = userData['email'] ?? 'venomversese91@gmail.com';
      userId = userData['uid'] ?? 'Unknown';
      userName = userData['name'] ?? 'Unknown';
      dob = userData['dob'] ?? 'Unknown';
      allergies = userData['allergies'] ?? 'Unknown';
      category = categoryName;
      name = snakeDetails['name'] ?? 'Unknown';
      imagePath = snakeDetails['imagePath']?.isNotEmpty == true
          ? snakeDetails['imagePath']
          : 'assets/snake.png';
      lethalityLevel = snakeDetails['lethalityLevel'] ?? 'Unknown';
      description = snakeDetails['description'] ?? 'Unknown';
      remedies = fetchedRemedies;
      finalConfidence = imageDataConfidence;
    });
  }

  Future<Map<String, String>> getRealTimeData() async {
    // Request location permission
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {"dateTime": "Location services are disabled", "location": "N/A"};
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return {"dateTime": "Permission denied forever", "location": "N/A"};
      }

      if (permission == LocationPermission.denied) {
        return {"dateTime": "Permission denied", "location": "N/A"};
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get current date and time
    String formattedDateTime =
        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    return {
      "dateTime": formattedDateTime,
      "location": "${position.latitude}° N, ${position.longitude}° E",
    };
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
      setState(() {
        confidence = confidence;
      });
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
                          PermissionStatus status =
                              await Permission.notification.request();
                          if (status.isDenied || status.isPermanentlyDenied) {
                            await openAppSettings();
                          }
                          Map<String, dynamic> dateAndLocation =
                              await getRealTimeData();
                          await PdfReport.generateReport(
                            userMail: userMailForPdf,
                            reportID: "RPT12345",
                            dateTime: dateAndLocation['dateTime'] ?? 'Unknown',
                            location: dateAndLocation['location'] ?? 'Unknown',
                            userID: userId,
                            userName: userName,
                            dob: dob,
                            allergies: allergies,
                            category: category,
                            scientificName: name,
                            image:
                                null, // Replace with image bytes if available
                            confidenceScore: finalConfidence * 100,
                            firstAidActions: remedies,
                            lethalityRisk: lethalityLevel,
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HospitalListScreen(), // Navigate to the hospital list
                  ),
                );

              },
              child: Container(
                width: 60,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(4, 4),
                    ),
                  ],
                  color: Color(0xFF800000),

                ),
                child: Image.asset(
                  'assets/panic.gif',
                  fit: BoxFit.cover,
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
