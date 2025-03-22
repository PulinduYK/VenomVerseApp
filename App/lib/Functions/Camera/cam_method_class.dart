import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Login_and_signup/Login_and_signup_logic/services/firebase.dart';
import '../Results_pages/result_screen.dart';

class CamMethodClass {
  final FirebaseService _firebaseService = FirebaseService();
  File? imageFile;

  // Function to check and request camera permission
  Future<bool> checkPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  // Function to pick an image from the camera
  Future<File?> pickImage(BuildContext context) async {
    bool hasPermission = await checkPermission();
    if (!hasPermission && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission denied")),
      );
      return null;
    }

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return null;

      return File(pickedFile.path);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // Function to crop the image
  Future<File?> cropImage(File image) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Crop Image",
        ),
      ],
    );

    return cropped != null ? File(cropped.path) : image;
  }

  // Function to send an image to the server
  Future<void> sendImageToServer(
      File image, int modelNum, BuildContext context) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse('http://142.93.212.199/predict'));
    request.files.add(await http.MultipartFile.fromPath("file", image.path));
    request.fields['model_id'] = modelNum.toString();

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        // Store the JSON response in a variable
        Map<String, dynamic> uploadedImageData = jsonResponse;

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                uploadedImageData: uploadedImageData,
                previousPage: "scan",
              ),
            ),
          );
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Image uploaded successfully!")),
          );
        }

        if (kDebugMode) {
          print(jsonResponse);
        }
      } else {
        await _firebaseService.insertHistory(modelNum, false, false, "none");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to upload image")),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
