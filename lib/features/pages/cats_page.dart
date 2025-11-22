import 'package:catire_mobile/data/cat_image_item.dart';
import 'package:flutter/material.dart';

import '../../core/models/image_model.dart';

class CatsPage extends StatelessWidget {
  static final List<ImageItem> images = catImages;

  const CatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats', style: TextStyle(color: Colors.grey[600])),
      ),
      body: images.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported,
                size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No images found',
              style:
              TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: images.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return ImageCard(imageItem: images[index]);
        },
      ),
    );
  }
}



class ImageCard extends StatelessWidget {
  final ImageItem imageItem;

  const ImageCard({
    super.key,
    required this.imageItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open image in full screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageFullScreenPage(
              imageItem: imageItem,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Image.asset(
                imageItem.imagePath,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 220,
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image,
                            size: 48, color: Colors.grey[600]),
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

class ImageFullScreenPage extends StatefulWidget {
  final ImageItem imageItem;

  const ImageFullScreenPage({
    super.key,
    required this.imageItem,
  });

  @override
  State<ImageFullScreenPage> createState() => _ImageFullScreenPageState();
}

class _ImageFullScreenPageState extends State<ImageFullScreenPage> {
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Zoomable image
          Expanded(
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 1,
              maxScale: 4,
              child: Image.asset(
                widget.imageItem.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image,
                            size: 64, color: Colors.grey[600]),
                        const SizedBox(height: 16),
                        Text(
                          'Image not found',
                          style:
                          TextStyle(color: Colors.grey[400], fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Caption at bottom
          Container(
            color: Colors.black87,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: SingleChildScrollView(
              child: Text(
                widget.imageItem.details,
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
