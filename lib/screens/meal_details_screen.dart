import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailsScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  void _showInfoMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2, milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoritesMealsProvider);
    final isFavorite = favoriteMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: Tween<double>(begin: 0.2, end: 1.0).animate(animation),
                child: child,
              ),
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFavorite),
              ),
            ),
            onPressed: () {
              final wasAdded = ref
                  .read(favoritesMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              if (wasAdded) {
                _showInfoMessage('Meal added to favorites', context);
              } else {
                _showInfoMessage('Meal removed from favorites', context);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Hero(
            tag: meal.id,
            child: Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          _buildIngredientsSection(context),
          const SizedBox(height: 8),
          _buildStepsSection(context),
        ],
      )),
    );
  }

  Widget _buildIngredientsSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        for (final ingredient in meal.ingredients)
          Text(ingredient,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.5))),
      ],
    );
  }

  Widget _buildStepsSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Steps',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        for (int i = 0; i < meal.steps.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text('${i + 1}. ${meal.steps[i]}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5))),
          ),
      ],
    );
  }
}
