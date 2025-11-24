import 'package:flutter/material.dart';

import '../news/article_history_section.dart';
import '../shared/section_header.dart';
import 'package:catire_mobile/core/models/article_model.dart';

/// Section widget that displays a list of articles read by the user.
class AccountHistorySection extends StatelessWidget {
  final List<ArticleInfo> articles;
  final Future<void> Function() onClear;

  const AccountHistorySection({
    super.key,
    required this.articles,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ArticleHistoryHeader(onClear: onClear),
        ArticleHistoryListSection(articles: articles),
      ],
    );
  }
}

/// Header widget for article history section.
class _ArticleHistoryHeader extends StatelessWidget {
  final Future<void> Function() onClear;

  const _ArticleHistoryHeader({required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SectionTitle(title: "ARTICLE HISTORY"),
        TextButton(
          onPressed: onClear,
          child: const Text(
            "Clear",
            style: TextStyle(
              fontSize: 14,
              color: Colors.redAccent,
              decoration: TextDecoration.underline,
              decorationColor: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
