import 'package:flutter/material.dart';

/// Text section with optional title.
Widget buildTextSection({String? title, required String content}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        // Display title if provided
        if (title != null) ...[
          Text(
            title,
            style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
        ],
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(height: 1.5),
        ),
      ],
    ),
  );
}
