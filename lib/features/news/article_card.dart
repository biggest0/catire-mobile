import 'package:flutter/material.dart';

import 'package:catire_mobile/core/utils/text_formatter.dart';
import '../../core/models/article_model.dart';

/// A tappable card widget that displays an article's information.
///
/// Includes the title, publication date, summary, category, and views.
/// Tapping the card triggers the [onTap] callback if provided.
class ArticleCard extends StatelessWidget {
  final ArticleInfo article;
  final VoidCallback? onTap;
  final bool hasBorder;
  final double padding;

  const ArticleCard({
    super.key,
    required this.article,
    this.onTap,
    this.hasBorder = true,
    this.padding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          // Based on hasBorder flag display border or not
          border: hasBorder
              ? const Border(bottom: BorderSide(color: Colors.grey, width: 1))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleTitle(title: article.title),
            ArticleDate(datePublished: article.datePublished),
            ArticleSummary(summary: article.summary),
            ArticleFooter(
              category: article.mainCategory,
              views: article.viewed,
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the title of an article.
///
/// Displays up to 2 lines and truncates overflow with an ellipsis.
class ArticleTitle extends StatelessWidget {
  final String title;

  const ArticleTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Displays the publication date of an article.
class ArticleDate extends StatelessWidget {
  final String datePublished;

  const ArticleDate({super.key, required this.datePublished});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        datePublished,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
    );
  }
}

/// Displays a short summary of an article.
///
/// Displays up to 3 lines and truncates overflow with an ellipsis.
class ArticleSummary extends StatelessWidget {
  final String summary;

  const ArticleSummary({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        summary,
        style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Displays the footer of the article card with category and views.
///
/// The category is shown on the left as a colored box
/// The Views is shown on the right as a grey text with an icon.
class ArticleFooter extends StatelessWidget {
  final String category;
  final int views;

  const ArticleFooter({super.key, required this.category, required this.views});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: article category
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            capitalize(category),
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ),

        // Right: article views
        Row(
          children: [
            Icon(Icons.visibility_outlined, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              views.toString(),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}
