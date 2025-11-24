import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';
import '../../core/services/database_service.dart';
import 'article_card.dart';
import 'article_detail_screen.dart';

/// A section widget that displays a paginated, inf scrollable list of articles.
class ArticleListSection extends StatefulWidget {
  final String? category;
  final String? search;
  final String? dateRange;
  final String? sortBy;

  const ArticleListSection({
    super.key,
    this.category,
    this.search,
    this.dateRange,
    this.sortBy,
  });

  @override
  State<ArticleListSection> createState() => _ArticleListSectionState();
}

class _ArticleListSectionState extends State<ArticleListSection> {
  List<ArticleInfo> _articles = []; // Currently loaded list of articles
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String? _error;
  final int _itemsPerPage = 10;

  final ScrollController _scrollController =
      ScrollController(); // Listen to scroll position

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll); // Set up scroll listener
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ArticleListSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.category != widget.category ||
        oldWidget.search != widget.search ||
        oldWidget.dateRange != widget.dateRange ||
        oldWidget.sortBy != widget.sortBy) {
      _refresh();
    }
  }

  /// Load articles for current page number
  Future<void> _loadArticles() async {
    if (_isLoading || !_hasMore) return;

    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('Loading page $_currentPage...');

      // Call API service
      final responses = await getArticles(
        page: _currentPage,
        limit: _itemsPerPage,
        category: widget.category,
        search: widget.search,
        dateRange: widget.dateRange,
        sortBy: widget.sortBy,
      );

      if (responses == null || responses.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
        return;
      }

      // Transform responses to entities
      final newArticles = responses.map((response) {
        return ArticleInfo(
          id: response.id,
          title: response.title,
          summary: response.summary,
          datePublished: response.datePublished,
          mainCategory: response.mainCategory,
          viewed: response.viewed,
        );
      }).toList();

      setState(() {
        _articles.addAll(newArticles);
        _currentPage++;
        _hasMore =
            newArticles.length ==
            _itemsPerPage; // If length == 10, there are more pages to load
        _isLoading = false;
      });

      print(
        '[Loaded] ${newArticles.length} articles (Total: ${_articles.length})',
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
      print('[Error] loading articles: $error');
    }
  }

  /// When near bottom, load more articles
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadArticles();
    }
  }

  /// Reset state and load first 10 articles
  Future<void> _refresh() async {
    setState(() {
      _articles = [];
      _currentPage = 1;
      _hasMore = true;
      _error = null;
    });
    await _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    // Initial loading state
    if (_isLoading && _articles.isEmpty) {
      return const _LoadingView();
    }

    // Error state
    if (_error != null && _articles.isEmpty) {
      return _ErrorView(error: _error!, onRetry: _refresh);
    }

    // Empty state
    if (_articles.isEmpty) {
      return const _EmptyView();
    }

    // Article list
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
        // Ensure scrollable to trigger refresh
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _articles.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Loading indicator at bottom
          if (index == _articles.length) {
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink(),
            );
          }

          // Article card
          final article = _articles[index];
          return ArticleCard(
            article: article,
            onTap: () async {
              final userDb = DatabaseHelper();
              await userDb.saveReadArticle(article);

              // Navigate to article detail
              print('Navigate to article: ${article.id}');
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArticleDetailScreen(articleId: article.id),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

/// Loading spinner widget for initial loading state
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// Display error message and retry button
class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text('Error: $error'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
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
          Icon(Icons.article_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No articles found',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
