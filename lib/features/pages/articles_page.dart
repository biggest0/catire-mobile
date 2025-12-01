import 'package:flutter/material.dart';

import '../news/category_slider.dart';
import 'package:catire_mobile/features/news/article_section.dart';

/// Articles page, displays a category slider and the corresponding list of articles.
class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = 'all';
  }

  /// Call back to update selected category.
  void onCategoryChanged(String? category) {
    print('Selected category: $category');
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category slider
        CategorySlider(
          selectedCategory: _selectedCategory,
          onCategoryChanged: onCategoryChanged,
        ),

        // Articles
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ArticleListSection(
              category: _selectedCategory,
              sortBy: 'newest',
            ),
          ),
        ),
      ],
    );
  }
}
