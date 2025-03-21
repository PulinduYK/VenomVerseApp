import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Results_pages/result_screen.dart';

class ImageCapture extends StatefulWidget {
  final int modelNum;

  const ImageCapture({super.key, required this.modelNum});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File? _imageFile;

  // Function to check and request camera permission
  Future<bool> _checkPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  // Function to pick image from camera
  Future<void> _pickImage() async {
    bool hasPermission = await _checkPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission denied")),
      );
      return;
    }

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;

      File selectedImg = File(pickedFile.path);

      setState(() {
        _imageFile = selectedImg;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  // Function to crop the image
  Future<void> _cropImage() async {
    if (_imageFile == null) return;

    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: _imageFile!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false, // Allows freeform cropping
        ),
        IOSUiSettings(
          title: "Crop Image",
        ),
      ],
    );

    setState(() {
      _imageFile = cropped != null ? File(cropped.path) : _imageFile;
    });
  }

  // Function to send image to a URI
  Future<void> _sendImageToServer() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected")),
      );
      return;
    }

    var request = http.MultipartRequest(
        "POST", Uri.parse('http://142.93.212.199/predict'));
    request.files
        .add(await http.MultipartFile.fromPath("file", _imageFile!.path));

    //Add the model number to the json
    request.fields['model_id'] = widget.modelNum.toString();

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        // Store the JSON response in a variable
        Map<String, dynamic> uploadedImageData = jsonResponse;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image uploaded successfully!")),
        );

        setState(() => _imageFile =
            null); // Clear the selection after uploading it to the server

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              uploadedImageData: uploadedImageData,
              previousPage: "scan",
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to upload image")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture & Upload Image")),
      body: Column(
        children: [
          if (_imageFile != null) ...[
            Image.file(_imageFile!),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _cropImage,
                  child: const Icon(Icons.crop),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _sendImageToServer,
                  child: const Icon(Icons.cloud_upload),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.camera_alt),
            label: const Text("Capture Image"),
          ),
        ],
      ),
    );
  }
}
