import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';

import '../Results_pages/result_screen.dart';

class UploadImagesPage extends StatefulWidget {
  @override
  _UploadImagesPageState createState() => _UploadImagesPageState();
}

class _UploadImagesPageState extends State<UploadImagesPage> {
  List<AssetEntity> _galleryImages = [];
  File? _selectedImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadGalleryImages();
  }

  Future<void> _loadGalleryImages() async {
    if ((await PhotoManager.requestPermissionExtend()).isAuth) {
      final albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      if (albums.isNotEmpty) {
        _galleryImages =
            await albums.first.getAssetListPaged(page: 0, size: 50);
        setState(() {});
      }
    } else {
      debugPrint("Permission Denied");
    }
  }

  Future<void> _selectImage(AssetEntity asset) async {
    final file = await asset.file;
    if (file != null) setState(() => _selectedImage = file);
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    setState(() => _isUploading = true);

    var uri = Uri.parse('http://142.93.212.199/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('file', _selectedImage!.path));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // Read and decode the JSON response
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        // Store the JSON response in a variable
        Map<String, dynamic> uploadedImageData = jsonResponse;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully!')),
        );

        // Example of using the stored variable
        print('Uploaded Image Data: $uploadedImageData');

        setState(() => _selectedImage = null); // Clear selection after upload

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              uploadedImageData: uploadedImageData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Upload Image',
            style: GoogleFonts.roboto(fontSize: 20, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: _galleryImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final asset = _galleryImages[index];
                  return GestureDetector(
                    onTap: () => _selectImage(asset),
                    child: FutureBuilder<File?>(
                      future: asset.file,
                      builder: (context, snapshot) {
                        final file = snapshot.data;
                        final isSelected = file?.path == _selectedImage?.path;
                        return snapshot.connectionState ==
                                    ConnectionState.done &&
                                file != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(file,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  if (isSelected)
                                    const Positioned(
                                      top: 5,
                                      right: 5,
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.green,
                                        child: Icon(Icons.check,
                                            color: Colors.white),
                                      ),
                                    ),
                                ],
                              )
                            : _placeholderImage();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          _uploadButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedImage != null ? _uploadImage : null,
        backgroundColor: Colors.redAccent,
        child: _isUploading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.cloud_upload, color: Colors.white),
      ),
    );
  }

  Widget _placeholderImage() => Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      );

  Widget _uploadButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ElevatedButton(
          onPressed:
              _selectedImage != null && !_isUploading ? _uploadImage : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            disabledBackgroundColor: Colors.grey.shade300,
            foregroundColor:
                _selectedImage != null ? Colors.white : Colors.grey.shade600,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: _selectedImage != null
                  ? const LinearGradient(
                      colors: [Colors.blueAccent, Colors.purpleAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              child: _isUploading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text('Upload',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      );
}

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: UploadImagesPage()));
