import 'package:flutter/material.dart';

import '../news/article_section.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String textInput = '';
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Search",
              border: const UnderlineInputBorder(),
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print("Submitting: $textInput");
                  setState(() {
                    search = textInput;
                  });
                },
              ),
            ),
            onChanged: (value) {
              setState(() {
                textInput = value;
              });
            },
          ),

          Expanded(
            child: ArticleListSection(
              search: search,
              category: 'all',
              sortBy: 'newest',
            ),
          ),
        ],
      ),
    );
  }
}
