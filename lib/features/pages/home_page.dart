import 'package:catire_mobile/data/home_page_item.dart';
import 'package:catire_mobile/features/image/image_card.dart';
import 'package:catire_mobile/features/news/horizontal_article_carousel.dart';
import 'package:catire_mobile/features/news/top_ten_section.dart';
import 'package:catire_mobile/features/shared/section_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const Divider(height: 1, thickness: 1, color: Colors.grey),
            ImageCard(imageItem: homeImage, hasBorder: true, space: 0),
            const SizedBox(height: 4),

            const SectionTitle(title: "STAFF PICKS"),
            HorizontalArticleCarousel(articles: selectedArticles),
            const SizedBox(height: 16), // ImageCard has margin bottom 12

            const SectionTitle(title: "TOP ARTICLES"),
            TopTenArticlesSection(),
          ],
        ),
      ),
    );
  }
}
