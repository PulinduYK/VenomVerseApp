import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../Login_and_signup/Login_and_signup_logic/services/notification_pdf.dart';

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
            "These details are generated based on the user's scan and are intended for reference and rough use only. Please verify the information using alternative methods before making any decisions. The Venom Verse team does not guarantee accuracy and assumes no responsibility for any consequences resulting from the use of this information.",
            style: pw.TextStyle(
              fontSize: 10,
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

  static Future<String> generateAndSendEmail(File file, String email) async {
    String msg;
    // Gmail SMTP credentials (Use your Gmail address and App Password)
    const String smtpUser =
        "venomversese91@gmail.com"; // Replace with your Gmail address
    const String smtpPassword =
        "mqsq lurk gtts yeae "; // Use the generated App Password

    try {
      final smtpServer = gmail(smtpUser, smtpPassword);

      // Create the email message (Ensure proper construction)
      final message = Message()
        ..from = Address(smtpUser, 'Venom Verse App') // Sender's email
        ..recipients.add(
          email,
        ) // Replace with recipient's email
        ..subject = 'Detection Report - Venom Verse' // Subject of email
        ..text =
            'Attached is the detection report for your recent scan.' // Body text
        ..attachments.add(FileAttachment(file)); // Attach PDF file

      // 5️⃣ Send the email
      await send(message, smtpServer);
      msg = "✅ Email Sent Successfully!";
      print("✅ Email Sent Successfully!");
    } catch (e) {
      msg = "❌ Error Sending Email: $e";
      print("❌ Error Sending Email: $e");
    }
    return msg;
  }

  static Future<void> generateReport({
    required String userMail,
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
              pw.Text("* Email: $userMail"),
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
    String newMsg = await generateAndSendEmail(file, userMail);
    await NotificationPdf().showNotification(
      title: 'VenomVerse',
      body: newMsg,
    );
    print(newMsg);

    // Open Preview
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
