import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/article_model.dart';

class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();
  static Database? _database;

  factory UserDatabase() {
    return _instance;
  }

  UserDatabase._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'user.db');

    return await openDatabase(
      path,
      version: 2, // Increment version for migration
      onCreate: (db, version) async {
        // Create users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            name TEXT,
            bio TEXT
          )
        ''');
        // Insert default user
        await db.insert('users', {'id': 1, 'name': 'Cat Person', 'bio': 'I have 2 Cats'});

        // Create read_articles table
        await db.execute('''
          CREATE TABLE read_articles (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            summary TEXT,
            datePublished TEXT,
            mainCategory TEXT,
            viewed INTEGER NOT NULL,
            readAt INTEGER NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Create read_articles table for existing databases
          await db.execute('''
            CREATE TABLE read_articles (
              id TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              summary TEXT,
              datePublished TEXT,
              mainCategory TEXT,
              viewed INTEGER NOT NULL,
              readAt INTEGER NOT NULL
            )
          ''');
        }
      },
    );
  }

  // User methods
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [1]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> updateUser(String name, String bio) async {
    final db = await database;
    await db.update(
      'users',
      {'name': name, 'bio': bio},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  // Article reading methods
  Future<void> saveReadArticle(ArticleInfo article) async {
    final db = await database;
    await db.insert(
      'read_articles',
      {
        'id': article.id,
        'title': article.title,
        'summary': article.summary,
        'datePublished': article.datePublished,
        'mainCategory': article.mainCategory,
        'viewed': article.viewed,
        'readAt': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Update if already exists
    );
    print('✅ Article saved to read history: ${article.title}');
  }

  Future<List<ArticleInfo>> getReadArticles({int? limit}) async {
    final db = await database;
    final result = await db.query(
      'read_articles',
      orderBy: 'readAt DESC', // Most recent first
      limit: limit,
    );

    return result.map((row) {
      return ArticleInfo(
        id: row['id'] as String,
        title: row['title'] as String,
        summary: row['summary'] as String?,
        datePublished: row['datePublished'] as String?,
        mainCategory: row['mainCategory'] as String?,
        viewed: row['viewed'] as int,
      );
    }).toList();
  }

  Future<bool> hasReadArticle(String articleId) async {
    final db = await database;
    final result = await db.query(
      'read_articles',
      where: 'id = ?',
      whereArgs: [articleId],
    );
    return result.isNotEmpty;
  }

  Future<void> clearReadArticles() async {
    final db = await database;
    await db.delete('read_articles');
    print('✅ Read history cleared');
  }

  Future<int> getReadArticlesCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM read_articles');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}