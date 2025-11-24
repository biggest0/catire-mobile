import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/database_service.dart';
import 'article_card.dart';
import 'article_detail_screen.dart';

/// A section widget that displays a list of articles read by the user.
class ArticleHistoryListSection extends StatelessWidget {
  final List<ArticleInfo> articles;

  const ArticleHistoryListSection({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    // Empty state
    if (articles.isEmpty) {
      return const _EmptyView();
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

/// Displays a message when no articles are found
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8),
          Text(
            'No articles found',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
