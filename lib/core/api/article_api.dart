import 'dart:convert';
import 'package:http/http.dart' as http;

import "package:catire_mobile/core/constants/api_routes.dart";


Future<Map<String, dynamic>> fetchArticleDetail(String articleId) async {
  final response = await http.post(
    Uri.parse(ApiRoutes.API_ARTICLE_DETAIL),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'id': articleId}),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    var jsonObject = jsonDecode(response.body) as Map<String, dynamic>;
    return jsonObject;
  } else {
    final errorMessage =
        'Failed to fetch article detail. Error: $response.statusCode - $response.body';
    throw Exception(errorMessage);
  }
}

Future<List<dynamic>> fetchArticles(Map<String, String> queryParams) async {
  final response = await http.get(
    Uri.parse(ApiRoutes.API_ARTICLE_INFO).replace(queryParameters: queryParams),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList;
  } else {
    final errorMessage =
        'Failed to fetch articles. Error: $response.statusCode - $response.body';
    throw Exception(errorMessage);
  }
}

Future<List<dynamic>> fetchTopTenArticles() async {
  final response = await http.get(
    Uri.parse(ApiRoutes.API_TOP_TEN),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList;
  } else {
    final errorMessage =
        'Failed to fetch top ten articles. Error: ${response.statusCode} - ${response.body}';
    throw Exception(errorMessage);
  }
}


void incrementArticleViewed(String articleId) {
  http.put(
    Uri.parse("${ApiRoutes.API_INCREMENT_VIEWED}/$articleId"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
