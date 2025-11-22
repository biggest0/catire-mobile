import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/database_service.dart';
import '../news/article_history_section.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final UserDatabase _userDb = UserDatabase();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  List<ArticleInfo> _readArticles = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadReadArticles();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // Load user data from database
  Future<void> _loadUserData() async {
    try {
      final user = await _userDb.getUser();
      if (user != null) {
        setState(() {
          _nameController.text = user['name'] ?? 'Cat Person';
          _bioController.text = user['bio'] ?? 'I love cats!!';
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() => _isLoading = false);
    }
  }

  // Save user data to database
  Future<void> _saveUserData() async {
    try {
      await _userDb.updateUser(_nameController.text, _bioController.text);
      print('User data saved');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
      }
    } catch (e) {
      print('[Error] saving user data: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving data: $e')));
      }
    }
  }

  Future<void> _loadReadArticles() async {
    try {
      final result = await _userDb.getReadArticles();
      print(result);
      setState(() {
        _readArticles = result;
      });
    } catch (e) {
      print('Error loading read articles: $e');
      setState(() {
        _readArticles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),

            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage(
                'assets/images/profile_pictures/cat_albert.jpg',
              ),
            ),

            const SizedBox(height: 24),

            // ---- ACCOUNT INFO title ----
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "ACCOUNT INFO",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // ---- Name TextField ----
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _saveUserData,
                ),
              ),
            ),

            // ---- Bio TextField ----
            const SizedBox(height: 12),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: "Bio",
                border: const UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _saveUserData,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---- ARTICLE HISTORY Header ----
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "ARTICLE HISTORY",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () async {
                    await UserDatabase().clearReadArticles();
                    if (mounted) {
                      setState(() {
                        _readArticles = [];
                      });
                    }
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.redAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),

            // ---- Article History List ----
            ArticleHistoryListSection(articles: _readArticles),
          ],
        ),
      ),
    );
  }
}
