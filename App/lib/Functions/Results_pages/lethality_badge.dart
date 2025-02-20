import 'package:flutter/material.dart';

class LethalityBadge extends StatelessWidget {
  final String level;
  final int confidence;

  const LethalityBadge({Key? key, required this.level, required this.confidence})
      : super(key: key);

  Color _getLethalityColor() {
    if (confidence <= 15) return Color(0xFF1F6D00); // Green (Low)
    if (confidence <= 60) return Color(0xFFEDDB12); // Yellow (Medium)
    return Color(0xFFFF0004); // Red (High)
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
            level.toUpperCase(),
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
            "$confidence%",
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
