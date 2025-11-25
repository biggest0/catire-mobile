import 'package:flutter/material.dart';

import 'package:catire_mobile/core/utils/text_formatter.dart';


/// Slider widget that allows the user to select a category.
class CategorySlider extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onCategoryChanged;

  final List<String> categories;

  const CategorySlider({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    this.categories = const [
      "all",
      'world',
      'lifestyle',
      'science',
      'technology',
      'business',
      'sport',
      'politics',
      'other',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          // Bold line spanning entire width
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: 2, color: Colors.grey[400]),
          ),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              // Category options
              final category = categories[index];
              final isSelected = selectedCategory == category;

              // Build each category
              return _buildCategoryChip(
                label: capitalize(category),
                isSelected: isSelected,
                onTap: () => onCategoryChanged(category),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.deepOrangeAccent : Colors.grey[700],
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
