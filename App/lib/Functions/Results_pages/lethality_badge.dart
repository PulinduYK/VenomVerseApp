import 'package:flutter/material.dart';

class LethalityBadge extends StatelessWidget {
  final String confidence;
  final String confidenceTxt;

  const LethalityBadge(
      {Key? key, required this.confidence, required this.confidenceTxt})
      : super(key: key);

  Color _getLethalityColor() {
    if (confidence == "None") return Color(0xFF1F6D00); // Green (None)
    if (confidence == "Low") return Color(0xFFEDDB12); // Yellow (Medium)
    if (confidence == "Medium") return Color(0xFFF3560E); // Orange (Medium)
    if (confidence == "High") return Color(0xFFFF0004); // Red (High)
    return Color(0xFFFFFFFF); // Wight (Not specified)
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getLethalityColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            confidence.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 6),
          Container(
            height: 16,
            width: 1.5,
            color: Colors.white, // White divider
          ),
          SizedBox(width: 6),
          Text(
            "$confidenceTxt",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
