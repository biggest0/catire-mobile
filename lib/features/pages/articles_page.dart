import 'package:flutter/material.dart';

import '../news/category_slider.dart';
import 'package:catire_mobile/features/news/article_section.dart';

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
        CategorySlider(
          selectedCategory: _selectedCategory,
          onCategoryChanged: onCategoryChanged,
        ),

        Expanded(
          child: ArticleListSection(
            category: _selectedCategory,
            sortBy: 'newest',
          ),
        ),
      ],
    );
  }
}
