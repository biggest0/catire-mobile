import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/article_model.dart';

class DatabaseHelper {
  //========================
  // Singleton db instance
  //=======================
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  /// Returns the singleton database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the SQLite database by creating tables on first run
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');

    return await openDatabase(
      path,
      version: 1,
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
        await db.insert('users', {
          'id': 1,
          'name': 'Cat12345',
          'bio': 'Cat Cat Cat!',
        });

        // Create read articles table
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
          // placeholder for future migrations and db version updates
        }
      },
    );
  }

  //=================
  // User db methods
  //=================
  /// Get user info from the database
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [1]);
    return result.isNotEmpty ? result.first : null;
  }

  /// Updates user info (name, bio) in the database
  Future<void> updateUser(String name, String bio) async {
    final db = await database;
    await db.update(
      'users',
      {'name': name, 'bio': bio},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  //===========================
  // Read Articles db methods
  //===========================
  /// Saves article to database, replace if already exists
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
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if already exists
    );
  }

  /// Get list of read articles, sorted by most recent first
  Future<List<ArticleInfo>> getReadArticles(int? limit) async {
    final db = await database;
    final articles = await db.query(
      'read_articles',
      orderBy: 'readAt DESC', // Most recent first
      limit: limit,
    );

    return articles.map((article) {
      return ArticleInfo(
        id: article['id'] as String,
        title: article['title'] as String,
        summary: article['summary'] as String,
        datePublished: article['datePublished'] as String,
        mainCategory: article['mainCategory'] as String,
        viewed: article['viewed'] as int,
      );
    }).toList();
  }

  /// Clear all read articles from the database
  Future<void> clearReadArticles() async {
    final db = await database;
    await db.delete('read_articles');
  }

  /// Get count of read articles
  Future<int> getReadArticlesCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM read_articles',
    );
    return result.first['count'] as int;
  }
}
