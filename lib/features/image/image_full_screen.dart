import 'package:flutter/material.dart';

import '../../core/models/image_model.dart';

/// Full screen widget that displays an image and its cat fact.
class ImageFullScreenPage extends StatelessWidget {
  final ImageItem imageItem;

  const ImageFullScreenPage({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.grey),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Image
          Expanded(
            child: Image.asset(
              imageItem.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Image not found',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Caption
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            color: Colors.black,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Text(
                imageItem.details,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
