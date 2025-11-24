import 'package:flutter/material.dart';

import '../../core/models/image_model.dart';
import 'image_full_screen.dart';

/// Widget that displays a single image card with a caption.
class ImageCard extends StatelessWidget {
  final ImageItem imageItem;

  const ImageCard({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open image in full screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageFullScreenPage(imageItem: imageItem),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // Clips image to fit
        child: ClipRRect(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Image.asset(
                imageItem.imagePath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                // Call back to handle when image fails to load
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 220,
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Image not found',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Caption
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  imageItem.caption,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
