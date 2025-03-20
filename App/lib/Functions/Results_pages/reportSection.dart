import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfReport {
  static Future<pw.Widget> buildHeader() async {
    // Load logo from assets (ensure you have the image in the assets folder)
    final ByteData imageData = await rootBundle.load('assets/playstore.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              "VenomVerse Team",
              style: pw.TextStyle(fontSize: 23, fontWeight: pw.FontWeight.bold),
            ),
            // Logo on Right Side
            pw.Image(
              pw.MemoryImage(imageBytes),
              width: 70, // Adjust size as needed
              height: 70,
            ),
          ],
        ),
        pw.Container(
          width: 300, // Set the width for text wrapping
          child: pw.Text(
            "This details are according to users scan, use alternative methods before confirm these detail and venomverse team not gurantee about these details and not responsible of usage results",
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColor(1.0, 0.0, 0.0), // Red color (RGB: 1.0, 0.0, 0.0)
            ),
            textAlign:
                pw.TextAlign.justify, // Optional: Align text to the center
            maxLines: null, // Allow the text to wrap across multiple lines
            softWrap: true, // Enable text wrapping
          ),
        ),
        // Title
        pw.SizedBox(height: 10), // Space before the line
        pw.Text(
          "Detailed Report",
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5), // Space before the line
        // Underline (Divider)
        pw.Container(
          width: double.infinity,
          height: 2,
          color: PdfColors.black,
        ),
      ],
    );
  }

  static Future<void> generateReport({
    required String reportID,
    required String dateTime,
    required String location,
    required String userID,
    required String userName,
    required String dob,
    required String allergies,
    required String category,
    required String scientificName,
    required String deviceModel,
    required Uint8List? image,
    required double confidenceScore,
    required List<String> firstAidActions,
    String lethalityRisk = "",
  }) async {
    // Function to create a bullet-point list
    pw.Widget buildBulletList(String title, List<String> items) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 5),
          ...items.map((item) => pw.Bullet(text: item)).toList(),
          pw.SizedBox(height: 10),
        ],
      );
    }

    final pdf = pw.Document();
    final header = await buildHeader();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              //await buildHeader(),
              header,
              pw.SizedBox(height: 5), // Space before the line
              pw.Text("Insect/Snake/Spider Detection Report",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),

              // Report Overview
              pw.Text("1. Report Overview",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("* Report ID: $reportID"),
              pw.Text("* Date and Time of Detection: $dateTime"),
              pw.Text("* Location: $location"),
              pw.Text("* User ID: $userID"),
              pw.SizedBox(height: 10),

              // User detail
              pw.Text("2. Personal Details",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("* Name: $userName"),
              pw.Text("* Date of Birth: $dob"),
              pw.Text("* Allergies: $allergies"),
              pw.SizedBox(height: 10),

              // Detected Species Details
              pw.Text("3. Detected Species Details",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("* Category: $category"),
              pw.Text("* Scientific Name: $scientificName"),
              pw.Text("* Device Model: $deviceModel"),
              pw.Text(
                  "* Confidence Score: ${confidenceScore.toStringAsFixed(2)}%"),
              if (image != null)
                pw.Image(pw.MemoryImage(image), width: 200, height: 200),
              pw.SizedBox(height: 10),

              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // First Aid Recommendations
                  buildBulletList(
                      "4. First Aid Recommendations", firstAidActions),
                ],
              ),

              // Medical Assistance & Risk Level
              pw.Text("5. Risk Level",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("* Lethality Risk Assessment: $lethalityRisk"),
            ],
          );
        },
      ),
    );

    // Save the file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Detection_Report.pdf");
    await file.writeAsBytes(await pdf.save());
    print("object");

    // Open Preview
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
