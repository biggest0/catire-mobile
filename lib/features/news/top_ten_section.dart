import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';
import '../../core/utils/tap_helper.dart';
import '../../core/utils/text_formatter.dart';
import 'empty_view.dart';
import 'error_view.dart';
import 'loading_view.dart';

/// Section of top ten articles
class TopTenArticlesSection extends StatefulWidget {
  const TopTenArticlesSection({super.key});

  @override
  State<TopTenArticlesSection> createState() => _TopTenArticlesSectionState();
}

class _TopTenArticlesSectionState extends State<TopTenArticlesSection> {
  List<ArticleInfo> _articles = [];
  bool _isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    try {
      final articles = await getTopTenArticles();
      if (mounted) {
        setState(() {
          if (articles != null) {
            _articles = articles;
            _isLoading = false;
          } else {
            errorMessage = "Failed to load articles";
            _isLoading = false;
          }
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingView();
    }

    if (errorMessage != null) {
      return ErrorView(error: errorMessage!, onRetry: _loadArticles);
    }

    if (_articles.isEmpty) {
      return const EmptyView();
    }

    return _TopTenListView(articles: _articles);
  }
}

/// List view of top ten articles
class _TopTenListView extends StatelessWidget {
  final List<ArticleInfo> articles;

  const _TopTenListView({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final article = articles[index];
        return _TopTenArticleItem(article: article, rank: index + 1);
      },
    );
  }
}

/// Individual article item for top ten articles
class _TopTenArticleItem extends StatelessWidget {
  final ArticleInfo article;
  final int rank;

  const _TopTenArticleItem({required this.article, required this.rank});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleTap(context, article),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _RankBadge(rank: rank),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Article category, viewed
                  Row(
                    children: [
                      Text(
                        capitalize(article.mainCategory),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.visibility_outlined,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        article.viewed.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

/// Rank badge for each article
class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: _getRankColor(), shape: BoxShape.circle),
      child: Center(
        child: Text(
          rank.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Get color based on rank
  Color _getRankColor() {
    if (rank == 1) return Colors.red[700]!;
    if (rank == 2) return Colors.orange[500]!;
    if (rank == 3) return Colors.amber[400]!;
    return Colors.grey[400]!;
  }
}
