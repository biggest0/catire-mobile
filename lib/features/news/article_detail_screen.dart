import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;

  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  ArticleDetail? _article;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchArticle();
  }

  Future<void> _fetchArticle() async {
    final result = await getArticleDetail(widget.articleId);
    setState(() {
      _article = result;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_article == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Failed to load article.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final article = _article!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            /// Title
            Text(
              article.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            /// Date
            Text(
              article.datePublished,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 16),

            /// Paragraphs
            ...article.paragraphs.map(
              (paragraph) => Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  paragraph,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Sub-categories
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: article.subCategory.map((category) {
                return Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
