import 'package:flutter/material.dart';
import '../../core/models/article_model.dart';
import '../../core/services/database_service.dart';
import 'article_card.dart';
import 'article_detail_screen.dart';

class ArticleHistoryListSection extends StatelessWidget {
  final List<ArticleInfo> articles;

  const ArticleHistoryListSection({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    // Empty state
    if (articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No articles read yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
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
            final userDb = UserDatabase();
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
