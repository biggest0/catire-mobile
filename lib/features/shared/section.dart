import 'package:flutter/material.dart';

Widget buildTextSection({String? title, required String content}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        // spread operator lets you put multiple widgets in a list based on a condition
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
