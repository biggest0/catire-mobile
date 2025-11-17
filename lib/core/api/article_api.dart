import 'dart:convert';
import 'package:catire_mobile/core/models/article_model.dart';
import 'package:http/http.dart' as http;

import "package:catire_mobile/core/constants/api_routes.dart";

import '../utils/data_formatter.dart';

Future<ArticleDetail> fetchArticleDetail(String articleId) async {
  final response = await http.post(
    Uri.parse(ApiRoutes.API_ARTICLE_DETAIL),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'id': articleId}),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    var jsonObject = jsonDecode(response.body) as Map<String, dynamic>;

    final articleResponse = ArticleDetailResponse.fromJson(jsonObject);
    final articleDetail = articleDetailTransform(articleResponse);

    return articleDetail;
  } else {
    final errorMessage =
        'Failed to fetch article detail. Error: $response.statusCode - $response.body';
    throw Exception(errorMessage);
  }
}

Future<List<ArticleInfoResponse>> fetchArticles({
  int page = 1,
  int limit = 10,
  String? category,
  String? search,
  String? dateRange,
  String? sortBy,
}) async {
  final queryParams = <String, String>{
    'page': page.toString(),
    'limit': limit.toString(),
    if (category != null) 'category': category,
    if (search != null) 'search': search,
    if (dateRange != null) 'dateRange': dateRange,
    if (sortBy != null) 'sortBy': sortBy,
  };

  final response = await http.get(
    Uri.parse(
      ApiRoutes.API_ARTICLE_DETAIL,
    ).replace(queryParameters: queryParams),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map(
          (jsonArticle) =>
              ArticleInfoResponse.fromJson(jsonArticle as Map<String, dynamic>),
        )
        .toList();
  } else {
    final errorMessage =
        'Failed to fetch articles. Error: $response.statusCode - $response.body';
    throw Exception(errorMessage);
  }
}
