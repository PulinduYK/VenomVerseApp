import 'package:flutter/material.dart';
import 'back_button.dart';
import 'lethality_badge.dart';
import 'immediate_actions.dart';
import 'description_section.dart';
import 'retake_button.dart';
import 'test_data.dart'; // Import test data

class ResultScreen extends StatefulWidget {
  final String snakeName;
  final String imagePath;
  final int confidence;
  final String description;
  final List<String> firstAidTips;

  const ResultScreen({
    Key? key,
    required this.snakeName,
    required this.imagePath,
    required this.confidence,
    required this.description,
    required this.firstAidTips,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String getLethalityLevel() {
    if (widget.confidence <= 15) return "Low";
    if (widget.confidence <= 60) return "Medium";
    return "High";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(widget.imagePath, fit: BoxFit.cover),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Result Title
                  Center(
                    child: Text(
                      "Result",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Snake Name & Lethality Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Snake Name Button
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.snakeName,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Lethality Badge
                      LethalityBadge(
                        level: getLethalityLevel(),
                        confidence: widget.confidence,
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Immediate Actions
                  Center(
                    child: Text(
                      "Immediate Actions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  ImmediateActionsSection(actions: widget.firstAidTips),
                  SizedBox(height: 15),

                  // Description Section
                  Center(
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  DescriptionSection(description: widget.description),

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
        ],
      ),
    );
  }
}