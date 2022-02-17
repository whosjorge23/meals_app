import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import './data/dummy_data.dart';
import './settings_screen.dart';
import './tabs_screen.dart';
import './category_meals_screen.dart';
import './categories_screen.dart';
import './meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List _availableMeals = DUMMY_MEALS;
  List _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] != null && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] != null && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] != null && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] != null && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Meals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
            .copyWith(secondary: const Color.fromARGB(255, 252, 155, 65)),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        "/": (context) => TabsScreen(
              filters: _filters,
              favoriteMeals: _favoriteMeals,
              saveFilters: _setFilters,
            ),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavorite: _toggleFavorite, isFavoriteMeal: _isMealFavorite),
        SettingsScreen.routeName: (context) => SettingsScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreen());
      },
    );
  }
}
