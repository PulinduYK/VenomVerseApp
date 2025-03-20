import 'package:flutter/material.dart';

import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';
import '../Functions/Hospital_suggestion/hospital_list.dart';
import '../Functions/Results_pages/back_button.dart';
import '../Functions/Results_pages/description_section.dart';
import '../Functions/Results_pages/immediate_actions.dart';
import '../Functions/Results_pages/lethality_badge.dart';

class ResultScreenLib extends StatefulWidget {
  final String name;
  final int modelNo;
  final int confidence;

  const ResultScreenLib({
    super.key,
    required this.name,
    required this.modelNo,
    required this.confidence,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreenLib> {
  final FirebaseService _firebaseService = FirebaseService();

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
    int modelNo = widget.modelNo;

    Map<String, dynamic> snakeDetails =
        await _firebaseService.getVenomDetailsByName(modelNo, widget.name);
    List<String> fetchedRemedies =
        await _firebaseService.getRemediesByName(modelNo, widget.name);

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
    int confidence = widget.confidence;
    confidence = confidence * 100;
    if (confidence < 90) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
              child: Text("Low Accuracy"),
            ),
            content: Text(
                "Image uploaded Successfully But The accuracy of the detection is low. Please retake the image for better results."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      });
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
                            width: 190, // Set a fixed width
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
                    SizedBox(height: 65),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HospitalListScreen(), // Navigate to the hospital list
                  ),
                );
              },
              shape: const CircleBorder(),
              child: Icon(Icons.wb_twighlight, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
