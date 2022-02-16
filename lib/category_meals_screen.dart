import 'package:flutter/material.dart';
import './data/dummy_data.dart';
import './models/meal.dart';
import './widgets/category_meals_screen_widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static String routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;
  final List availableMeals;

  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    final categoryTitle = routeArgs['title'].toString();
    final categotyId = routeArgs['id'].toString();
    final categoryColor = routeArgs['color'];
    final categoryMeals = availableMeals.where((meal) {
      return meal.categories.contains(categotyId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        foregroundColor: Colors.white,
        backgroundColor: categoryColor as Color,
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability);
        }),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
