import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String routeName) onNavigate;

  const MainDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  const SizedBox(width: 18),
                  Text(
                    'Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )),
          buildListTile(context, 'Meals', Icons.restaurant, () {
            onNavigate('meals');
          }),
          buildListTile(context, 'Filters', Icons.settings, () {
            onNavigate('filters');
          }),
        ],
      ),
    );
  }

  Widget buildListTile(
      BuildContext context, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
      onTap: () => tapHandler(),
    );
  }
}
