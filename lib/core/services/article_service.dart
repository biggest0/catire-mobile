import 'dart:developer';
import 'package:catire_mobile/core/models/article_model.dart';

import '../api/article_api.dart';
import '../utils/data_formatter.dart';

/// Send and handle response from article detail API call
Future<ArticleDetail?> getArticleDetail(String articleId) async {
  try {
    final data = await fetchArticleDetail(articleId);
    final articleResponse = ArticleDetailResponse.fromJson(data);
    final articleDetail = articleDetailTransform(articleResponse);

    return articleDetail;
  } catch (error) {
    log("Failed to get article detail:$error");
    return null;
  }
}

/// Send and handle response from article info API call
Future<List<ArticleInfo>?> getArticles({
  int page = 1,
  int limit = 10,
  String? category,
  String? search,
  String? dateRange,
  String? sortBy,
}) async {
  try {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      if (category != null) 'category': category,
      if (search != null) 'search': search,
      if (dateRange != null) 'dateRange': dateRange,
      if (sortBy != null) 'sortBy': sortBy,
    };
    final data = await fetchArticles(queryParams);
    return data
        .map(
          (jsonArticle) =>
              ArticleInfoResponse.fromJson(jsonArticle as Map<String, dynamic>),
        )
        .map(articleInfoTransform)
        .toList();
  } catch (error) {
    log("Failed to get article info:$error");
    return null;
  }
}

/// Send and handle response from top ten articles API call
Future<List<ArticleInfo>?> getTopTenArticles() async {
  try {
    final data = await fetchTopTenArticles();
    return data
        .map(
          (jsonArticle) =>
              ArticleInfoResponse.fromJson(jsonArticle as Map<String, dynamic>),
        )
        .map(articleInfoTransform)
        .toList();
  } catch (error) {
    log("Failed to get top ten articles:$error");
    return null;
  }
}
