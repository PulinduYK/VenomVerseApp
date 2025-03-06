import 'package:flutter/material.dart';

class ImmediateActionsSection extends StatelessWidget {
  final List<String> actions; // List of bullet points

  const ImmediateActionsSection({Key? key, required this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Centered Header: Immediate Actions
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
          child: Center(
            child: Text(
              "Immediate Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),

        // Bullet Points (List of Actions)
        Container(
          padding: EdgeInsets.all(30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: actions.map((action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.black), // Bullet point icon
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        action,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
