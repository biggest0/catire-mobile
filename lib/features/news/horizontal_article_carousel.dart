import 'package:catire_mobile/features/news/article_card.dart';
import 'package:flutter/material.dart';
import '../../core/models/article_model.dart';
import '../../core/services/database_service.dart';
import 'article_detail_screen.dart';

/// A horizontal swipable carousel of article cards
class HorizontalArticleCarousel extends StatelessWidget {
  final List<ArticleInfo> articles;
  final double height;
  final EdgeInsets padding;

  const HorizontalArticleCarousel({
    super.key,
    required this.articles,
    this.height = 220,
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return _HorizontalArticleCard(
            article: article,
            isFirst: index == 0,
            isLast: index == articles.length - 1,
          );
        },
      ),
    );
  }
}

/// Individual article card for horizontal scrolling
class _HorizontalArticleCard extends StatelessWidget {
  final ArticleInfo article;
  final bool isFirst;
  final bool isLast;

  const _HorizontalArticleCard({
    required this.article,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      margin: EdgeInsets.only(right: isLast ? 0 : 12),
      child: ArticleCard(
        article: article,
        onTap: () => _handleTap(context),
        hasBorder: false,
      ),
    );
  }

  // Save article to database and navigate to article detail screen when tapped
  Future<void> _handleTap(BuildContext context) async {
    final userDb = DatabaseHelper();
    await userDb.saveReadArticle(article);

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetailScreen(articleId: article.id),
        ),
      );
    }
  }
}
