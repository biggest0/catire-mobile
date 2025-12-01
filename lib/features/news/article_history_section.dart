import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import 'article_card.dart';
import 'package:catire_mobile/features/news/empty_view.dart';
import 'package:catire_mobile/core/utils/tap_helper.dart';

/// Section to display a list of articles read by the user.
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
          onTap: () => handleTap(context, article),
        );
      },
    );
  }
}
