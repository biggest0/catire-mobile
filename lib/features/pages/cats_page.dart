import 'package:flutter/material.dart';

import '../../core/models/image_model.dart';
import '../image/image_card.dart';
import 'package:catire_mobile/data/cat_image_item.dart';

/// Image page for cat facts and cat pictures
class CatsPage extends StatelessWidget {
  static final List<ImageItem> images = catImages;

  const CatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: images.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No images found',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: images.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return ImageCard(imageItem: images[index]);
              },
            ),
    );
  }
}
