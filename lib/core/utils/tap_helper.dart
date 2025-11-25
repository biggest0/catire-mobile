import 'package:catire_mobile/core/api/article_api.dart';
import 'package:catire_mobile/core/models/article_model.dart';
import 'package:flutter/material.dart';

import '../../features/news/article_detail_screen.dart';
import '../services/database_service.dart';

/// Save article to database and navigate to article detail screen when tapped
Future<void> handleTap(BuildContext context, ArticleInfo article) async {
  final userDb = DatabaseHelper();
  await userDb.saveReadArticle(article);
  incrementArticleViewed(article.id);

  if (context.mounted) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(articleId: article.id),
      ),
    );
  }
}