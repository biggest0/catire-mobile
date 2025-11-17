class ArticleInfoResponse {
  final String id;
  final String title;
  final String? summary;
  final String datePublished;
  final String mainCategory;
  final int viewed;

  ArticleInfoResponse({
    required this.id,
    required this.title,
    this.summary,
    required this.datePublished,
    required this.mainCategory,
    required this.viewed,
  });

  factory ArticleInfoResponse.fromJson(Map<String, dynamic> json) {
    return ArticleInfoResponse(
      id: json['_id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      datePublished: json['date_published'] as String,
      mainCategory: json['main_category'] as String,
      viewed: json['viewed'] as int,
    );
  }
}

class ArticleInfo {
  final String id;
  final String title;
  final String? summary;
  final String? datePublished; // Formatted date string
  final String? mainCategory;
  final int viewed;

  ArticleInfo({
    required this.id,
    required this.title,
    this.summary,
    this.datePublished,
    this.mainCategory,
    required this.viewed,
  });
}

class ArticleDetailResponse {
  final String id;
  final String datePublished;
  final String title;
  final String? summary;
  final List<String> paragraphs;
  final String mainCategory;
  final List<String> subCategory;
  final String source;
  final String url;

  ArticleDetailResponse({
    required this.id,
    required this.datePublished,
    required this.title,
    this.summary,
    required this.paragraphs,
    required this.mainCategory,
    required this.subCategory,
    required this.source,
    required this.url,
  });

  factory ArticleDetailResponse.fromJson(Map<String, dynamic> json) {
    return ArticleDetailResponse(
      id: json['_id'] as String,
      datePublished: json['date_published'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      paragraphs: (json['paragraphs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mainCategory: json['main_category'] as String,
      subCategory: (json['sub_category'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      source: json['source'] as String,
      url: json['url'] as String,
    );
  }
}

class ArticleDetail {
  final String id;
  final String datePublished;
  final String title;
  final String? summary;
  final List<String> paragraphs;
  final String mainCategory;
  final List<String> subCategory;
  final String source;
  final String url;

  ArticleDetail({
    required this.id,
    required this.datePublished,
    required this.title,
    this.summary,
    required this.paragraphs,
    required this.mainCategory,
    required this.subCategory,
    required this.source,
    required this.url,
  });
}
