import 'package:flutter/material.dart';

import '../../core/models/article_model.dart';
import '../../core/services/database_service.dart';
import 'package:catire_mobile/features/account/account_history_section.dart';
import 'package:catire_mobile/features/account/account_info_section.dart';
import 'package:catire_mobile/features/account/profile_picture.dart';

/// Account page, user profile and article read history.
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final DatabaseHelper _userDb = DatabaseHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Hardcoded profile picture for now, need to implement uploading and API storage in future
  final String imagePath = 'assets/images/profile_pictures/cat_albert.jpg';

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

  /// Load user data from database.
  Future<void> _loadUserData() async {
    try {
      final user = await _userDb.getUser();
      if (user != null) {
        setState(() {
          _nameController.text = user['name'] ?? '';
          _bioController.text = user['bio'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (error) {
      print('Error loading user data: $error');
      setState(() => _isLoading = false);
    }
  }

  /// Save user data to database.
  Future<void> _saveUserData() async {
    try {
      await _userDb.updateUser(_nameController.text, _bioController.text);
      print('User data saved');

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Saved successfully!')));
      }
    } catch (error) {
      print('[Error] saving user data: $error');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving data: $error')));
      }
    }
  }

  /// Read articles from database.
  Future<void> _loadReadArticles() async {
    try {
      final result = await _userDb.getReadArticles(null);
      print(result);
      setState(() {
        _readArticles = result;
      });
    } catch (error) {
      print('Error loading read articles: $error');
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePicture(imagePath: imagePath),
            const SizedBox(height: 24),

            AccountInfoSection(
              nameController: _nameController,
              bioController: _bioController,
              onSave: _saveUserData,
            ),
            const SizedBox(height: 30),

            AccountHistorySection(
              articles: _readArticles,
              onClear: () async {
                await _userDb.clearReadArticles();
                if (mounted) {
                  setState(() {
                    _readArticles = [];
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
