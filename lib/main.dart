import 'package:flutter/material.dart';

import 'package:catire_mobile/features/layout/bottom_bar.dart';
import 'package:catire_mobile/features/layout/top_bar.dart';
import 'package:catire_mobile/features/pages/account_page.dart';
import 'package:catire_mobile/features/pages/home_page.dart';
import 'package:catire_mobile/features/pages/search_page.dart';
import 'package:catire_mobile/features/pages/menu_page.dart';
import 'package:catire_mobile/features/pages/articles_page.dart';
import 'package:catire_mobile/features/pages/cats_page.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Pages
  final List<Widget> _pages = [
    const HomePage(),
    const ArticlesPage(),
    const CatsPage(),
    const AccountPage(),
    const MenuPage(),
    const SearchPage(),
  ];

  void _onIconTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onTap: _onIconTap),

      body: _pages[_selectedIndex],

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onIconTap,
      ),
    );
  }
}
