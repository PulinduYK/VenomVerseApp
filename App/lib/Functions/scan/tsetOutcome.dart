import 'package:flutter/material.dart';

class TestOutcome extends StatelessWidget {
  final Map<String, dynamic> uploadedImageData;

  const TestOutcome({super.key, required this.uploadedImageData});

  @override
  Widget build(BuildContext context) {
    // Extracting accuracy and class values
    double confidence =
        uploadedImageData['confidence']?.toDouble() * 100 ?? 0.0;
    double prediction = uploadedImageData['prediction']?.toDouble() ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Test Outcome')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upload Result:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text('Accuracy: $confidence%',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text('Detected Class: $prediction',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
