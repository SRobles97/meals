import 'package:flutter/material.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;

  const MealsScreen(
      {Key? key,
      this.title,
      required this.meals,})
      : super(key: key);

  void _onMealSelected(BuildContext context, Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealDetailsScreen(
                  meal: meal,
                )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Uh oh... nothing here',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          const SizedBox(height: 16),
          Text('Try changing your filters',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5))),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
              meal: meals[index],
              onMealSelected: (meal) => _onMealSelected(context, meal));
        },
        itemCount: meals.length,
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
