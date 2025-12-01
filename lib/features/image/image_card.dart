import 'package:flutter/material.dart';

import '../../core/models/image_model.dart';
import 'image_full_screen.dart';

/// Widget that displays a single image card with a caption.
class ImageCard extends StatelessWidget {
  final ImageItem imageItem;
  final bool hasBorder;
  final double space;

  const ImageCard({super.key, required this.imageItem, this.hasBorder = true, this.space = 8});

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
        margin: EdgeInsets.symmetric(horizontal: space, vertical: 12),
        decoration: BoxDecoration(
          // Default flutter background color
          color: Theme.of(context).canvasColor,
          // Based on hasBorder flag display border or not
          border: hasBorder
              ? const Border(bottom: BorderSide(color: Colors.grey, width: 1))
              : null,
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
                // In case image fails, display something
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
