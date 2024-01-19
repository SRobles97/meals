import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final existingIndex = state.indexWhere((element) => element.id == meal.id);
    if (existingIndex >= 0) {
      state = [...state]..removeAt(existingIndex);
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
  return FavoritesNotifier();
});
