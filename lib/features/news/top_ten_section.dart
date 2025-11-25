import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';
import '../../core/services/database_service.dart';
import 'article_detail_screen.dart';
import 'empty_view.dart';

class TopTenArticlesWidget extends StatefulWidget {
  const TopTenArticlesWidget({super.key});

  @override
  State<TopTenArticlesWidget> createState() => _TopTenArticlesWidgetState();
}

class _TopTenArticlesWidgetState extends State<TopTenArticlesWidget> {
  List<ArticleInfo> _articles = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final articles = await getTopTenArticles();
      if (mounted) {
        setState(() {
          if (articles != null) {
            _articles = articles;
            _isLoading = false;
          }
          else {
            _error = "Failed to load articles";
            _isLoading = false;
          }
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (_isLoading) {
    //   return const _LoadingView();
    // }
    //
    // if (_error != null) {
    //   return _ErrorView(
    //     error: _error!,
    //     onRetry: _loadArticles,
    //   );
    // }

    if (_articles.isEmpty) {
      return const EmptyView();
    }

    return _TopTenListView(articles: _articles);
  }
}

class _TopTenListView extends StatelessWidget {
  final List<ArticleInfo> articles;

  const _TopTenListView({required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final article = articles[index];
        return _TopTenArticleItem(
          article: article,
          rank: index + 1,
        );
      },
    );
  }
}

class _TopTenArticleItem extends StatelessWidget {
  final ArticleInfo article;
  final int rank;

  const _TopTenArticleItem({
    required this.article,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RankBadge(rank: rank),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Row(
                    children: [
                      Text(
                        article.mainCategory.toUpperCase(),
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
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
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

class _RankBadge extends StatelessWidget {
  final int rank;

  const _RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: _getRankColor(),
        shape: BoxShape.circle,
      ),
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

  Color _getRankColor() {
    if (rank == 1) return Colors.amber[700]!; // Gold
    if (rank == 2) return Colors.grey[600]!; // Silver
    if (rank == 3) return Colors.brown[400]!; // Bronze
    return Colors.blue[600]!; // Default
  }
}