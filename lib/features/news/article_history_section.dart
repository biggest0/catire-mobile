import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/database_service.dart';
import 'article_card.dart';
import 'article_detail_screen.dart';
import 'package:catire_mobile/features/news/empty_view.dart';

/// A section widget that displays a list of articles read by the user.
class ArticleHistoryListSection extends StatelessWidget {
  final List<ArticleInfo> articles;

  const ArticleHistoryListSection({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    // Empty state
    if (articles.isEmpty) {
      return const EmptyView();
    }

    // Article list
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleCard(
          article: article,
          onTap: () async {
            final userDb = DatabaseHelper();
            await userDb.saveReadArticle(article);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ArticleDetailScreen(articleId: article.id),
              ),
            );
          },
        );
      },
    );
  }
}