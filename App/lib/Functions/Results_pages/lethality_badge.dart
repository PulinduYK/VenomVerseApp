import 'package:flutter/material.dart';

class LethalityBadge extends StatelessWidget {
  final String confidence;

  const LethalityBadge({
    Key? key,
    required this.confidence,
  }) : super(key: key);

  Color _getLethalityColor() {
    if (confidence == "None") return const Color(0xFF1F6D00); // Green (None)
    if (confidence == "Low") return const Color(0xFFEDDB12); // Yellow (Medium)
    if (confidence == "Medium") return const Color(0xFFF3560E); // Orange (Medium)
    if (confidence == "High") return const Color(0xFFFF0004); // Red (High)
    return const Color(0xFF3104DF); // Wight (Not specified)
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth * 0.9), // Set max width
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getLethalityColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            // Ensures text wraps properly
            child: Text(
              "Venomous Level",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
              softWrap: true,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            height: 16,
            width: 1.5,
            color: Colors.white, // White divider
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              confidence,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
