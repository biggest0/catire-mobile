import 'package:intl/intl.dart';
import '../models/article_model.dart';

ArticleInfo articleInfoTransform(ArticleInfoResponse response) {
  final parsedDate = DateTime.parse(response.datePublished);
  final formattedDate = DateFormat('MM/dd/yyyy').format(parsedDate);

  return ArticleInfo(
    id: response.id,
    title: response.title,
    summary: response.summary,
    datePublished: formattedDate,
    mainCategory: response.mainCategory,
    viewed: response.viewed,
  );
}

ArticleDetail articleDetailTransform(ArticleDetailResponse response) {
  final parsedDate = DateTime.parse(response.datePublished);
  final formattedDate = DateFormat('MM/dd/yyyy').format(parsedDate);

  return ArticleDetail(
    id: response.id,
    datePublished: formattedDate,
    title: response.title,
    summary: response.summary,
    paragraphs: response.paragraphs,
    mainCategory: response.mainCategory,
    subCategory: response.subCategory,
    source: response.source,
    url: response.url,
  );
}
