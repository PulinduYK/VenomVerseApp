import 'package:flutter/material.dart';
import '../scan/gallery.dart';
import '../Camera/camMethodClass.dart';
import '../Camera/camPage.dart';

class RetakeButton extends StatelessWidget {
  final VoidCallback? onPressed; // Allows passing an action
  final String buttonName;
  final String previousPage;

  const RetakeButton({Key? key, this.onPressed, required this.buttonName,required this.previousPage,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Adjust height as needed
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 120,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [Color(0xff8A7FD6), Color(0xff6D5FD5),],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed:
              onPressed ?? () {
                _navigateBack(context, previousPage);
              },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh, color: Colors.white), // White icon
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  buttonName,
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 3, // Allows wrapping up to 3 lines
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Function to handle navigation based on `previousPage
  void _navigateBack(BuildContext context, String previousPage) {
    if (previousPage == "scan") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CamPage(modelNum: 1)),
      );
    } else if (previousPage == "upload") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UploadImagesPage(modelNum: 1)),
      );
    }
  }
}
