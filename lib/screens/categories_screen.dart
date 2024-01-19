import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;

  const CategoriesScreen(
      {Key? key,
      required this.availableMeals})
      : super(key: key);

  void _onTap(BuildContext context, Category selectedCategory) {
    final displayedMeals = availableMeals
        .where((meal) => meal.categories.contains(selectedCategory.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealsScreen(
                  title: '${selectedCategory.title} meals',
                  meals: displayedMeals,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: availableCategories
          .map((category) => CategoryGridItem(
                category: category,
                onTap: () => _onTap(context, category),
              ))
          .toList(),
    );
  }
}
