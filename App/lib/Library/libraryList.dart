import 'package:flutter/material.dart';
import 'package:venomverse/Library/result_screen_lib.dart';

import '../Functions/Results_pages/back_button.dart';
import '../Login_and_signup/Login_and_signup_logic/services/firebase.dart';

class libraryList extends StatefulWidget {
  final String category;
  final int modelNo;
  const libraryList({super.key, required this.category, required this.modelNo});

  @override
  State<libraryList> createState() => _libraryListState();
}

class _libraryListState extends State<libraryList> {
  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Map<String, dynamic>>> Function() returnFunctionBasedOnString(
      String input) {
    if (widget.category == 'Snakes') {
      return () => _firebaseService.getAllSnakes(); // Always return a Future
    } else if (widget.category == 'Spiders') {
      return () => _firebaseService.getAllSpiders(); // Always return a Future
    } else if (widget.category == 'Insects') {
      return () => _firebaseService.getAllInsects(); // Always return a Future
    } else {
      return () => _firebaseService
          .getAllSnakes(); // Default case, always return a Future
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1C16B9),
              Color(0xFF6D5FD5),
              Color(0xFF8A7FD6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0),
                child: SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      CustomBackButton(),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${widget.category} List",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40.00),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 10.0),
                    child: Center(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: returnFunctionBasedOnString(widget.category)(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError ||
                              !snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                                child: Text(
                                    "No species found in ${widget.category}"));
                          }

                          List<Map<String, dynamic>> speciesList =
                              snapshot.data!;

                          return ListView.builder(
                            itemCount: speciesList.length,
                            itemBuilder: (context, index) {
                              String name = speciesList[index]["name"]!;
                              String imagePath =
                                  speciesList[index]["imagePath"]!;

                              return Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreenLib(
                                          confidence: 1,
                                          modelNo: widget.modelNo,
                                          name: name,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.asset(
                                            imagePath,
                                            width: 110,
                                            height: 110,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Icon(Icons.image_not_supported,
                                                    size: 60),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
