import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/article_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _inputTitle = '';
  String _title = 'empty';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Input field
            TextField(
              onChanged: (String text) {
                setState(() {
                  _inputTitle = text;
                });
              },
              decoration: const InputDecoration(
                hintText: "Enter some data",
                labelText: "Data input",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Submit button
            ElevatedButton(
              onPressed: _isLoading ? null : () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  List<ArticleInfo>? newAlbumData = await getArticles();
                  setState(() {
                    _title = newAlbumData?.isNotEmpty == true
                        ? newAlbumData![0].title
                        : 'No data';
                    _isLoading = false;
                  });
                } catch (error) {
                  setState(() {
                    _title = 'Error: $error';
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Submit data to server'),
            ),

            const SizedBox(height: 24),

            // Response section
            const Text(
              "RESPONSE:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}