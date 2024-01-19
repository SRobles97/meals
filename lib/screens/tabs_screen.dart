import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../providers/filters_providers.dart';
import 'categories_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  String _title = 'Categories';
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      if (index == 0) {
        _title = 'Categories';
      } else {
        _title = 'Favorites';
      }
    });
  }

  void _navigateTo(String routeName) {
    Navigator.of(context).pop();
    if (routeName == 'filters') {
      Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoritesMealsProvider);
    final availableMeals = ref.watch(filteredMealsProvider);
    final List<Widget> pages = [
      CategoriesScreen(
        availableMeals: availableMeals,
      ),
      MealsScreen(
        meals: favoriteMeals,
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      drawer: MainDrawer(
        onNavigate: _navigateTo,
      ),
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
