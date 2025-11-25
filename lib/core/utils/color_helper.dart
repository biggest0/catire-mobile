import 'package:flutter/material.dart';

/// Get color for rank badge
Color getRankColor(int rank) {
  switch (rank) {
    case 1:
      return Colors.red.shade700;
    case 2:
      return Colors.orange.shade500;
    case 3:
      return Colors.amber.shade400;
    default:
      return Colors.grey.shade400;
  }
}

/// Get category text color
Color getTextColor(String category) {
  switch (category) {
    case 'world':
      return Colors.red;
    case 'lifestyle':
      return Colors.orange.shade900;
    case 'science':
      return Colors.teal;
    case 'technology':
      return Colors.blue;
    case 'business':
      return Colors.brown.shade700;
    case 'sport':
      return Colors.green;
    case 'politics':
      return Colors.purple;
    default:
      return Colors.grey;
  }
}

/// Get category box color
Color getBoxColor(String category) {
  switch (category) {
    case 'world':
      return Colors.red.shade50;
    case 'lifestyle':
      return Colors.orange.shade50;
    case 'science':
      return Colors.teal.shade50;
    case 'technology':
      return Colors.blue.shade50;
    case 'business':
      return Colors.brown.shade100;
    case 'sport':
      return Colors.green.shade50;
    case 'politics':
      return Colors.purple.shade50;
    default:
      return Colors.grey.shade50;
  }
}