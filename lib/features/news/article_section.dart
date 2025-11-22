import 'package:flutter/material.dart';
import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';
import '../../core/services/database_service.dart';
import 'article_card.dart';
import 'article_detail_screen.dart';

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
  List<ArticleInfo> _articles = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String? _error;
  final int _itemsPerPage = 10;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _scrollController.addListener(_onScroll);
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

      // Reset and fetch new data
      _refresh();
    }
  }


  // Load articles for current page
  Future<void> _loadArticles() async {
    print("test ${widget.search}");
    if (_isLoading || !_hasMore) return;

    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      print('📤 Loading page $_currentPage...');

      // Call your API service
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
        _hasMore = newArticles.length == _itemsPerPage;
        _isLoading = false;
      });

      print('[Loaded] ${newArticles.length} articles (Total: ${_articles.length})');

    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
      print('[Error] loading articles: $error');
    }
  }

  // Infinite scroll listener
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadArticles();
    }
  }

  // Pull to refresh
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error state (with no articles)
    if (_error != null && _articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refresh,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Empty state
    if (_articles.isEmpty) {
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

    // Article list with pagination
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
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
              final userDb = UserDatabase();
              await userDb.saveReadArticle(article);

              // Navigate to article detail
              print('Navigate to article: ${article.id}');
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailScreen(articleId: article.id),
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