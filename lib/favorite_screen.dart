import 'package:flutter/material.dart';
import './widgets/category_meals_screen_widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List favoriteMeals;
  const FavoriteScreen({Key? key, required this.favoriteMeals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text("You have no favorites yet - start adding some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
              id: favoriteMeals[index].id,
              title: favoriteMeals[index].title,
              imageUrl: favoriteMeals[index].imageUrl,
              duration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability);
        }),
        itemCount: favoriteMeals.length,
      );
    }
  }
}
