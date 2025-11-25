import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';
import '../../core/utils/tap_helper.dart';
import 'article_card.dart';
import 'package:catire_mobile/features/news/empty_view.dart';
import 'error_view.dart';
import 'loading_view.dart';

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
  String? errorMessage;
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
      errorMessage = null;
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
        errorMessage = error.toString();
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
      errorMessage = null;
    });
    await _loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    // Initial loading state
    if (_isLoading && _articles.isEmpty) {
      return const LoadingView();
    }

    // Error state
    if (errorMessage != null && _articles.isEmpty) {
      return ErrorView(error: errorMessage!, onRetry: _refresh);
    }

    // Empty state
    if (_articles.isEmpty) {
      return const EmptyView();
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
            onTap:() => handleTap(context, article)
          );
        },
      ),
    );
  }
}