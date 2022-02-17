import 'package:flutter/material.dart';
import '/settings_screen.dart';
import './favorite_screen.dart';
import './categories_screen.dart';
import './models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List favoriteMeals;
  final Map<String, bool> filters;
  final Function saveFilters;
  const TabsScreen(
      {Key? key,
      required this.filters,
      required this.saveFilters,
      required this.favoriteMeals})
      : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {"page": const CategoriesScreen(), "title": "Meal Categories"},
      {
        "page": FavoriteScreen(favoriteMeals: widget.favoriteMeals),
        "title": "Favorites"
      },
      {
        "page": SettingsScreen(
            filters: widget.filters, saveFilters: widget.saveFilters),
        "title": "Settings"
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIdex) => _selectPage(currentIdex),
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
