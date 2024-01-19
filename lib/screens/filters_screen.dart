import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_providers.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: <Widget>[
          _buildSwitchListTile(
            'Gluten-free',
            'Only include gluten-free meals.',
            activeFilters[Filter.glutenFree]!,
            (newValue) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.glutenFree,
                    newValue,
                  );
            },
            context,
          ),
          _buildSwitchListTile(
            'Lactose-free',
            'Only include lactose-free meals.',
            activeFilters[Filter.lactoseFree]!,
            (newValue) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.lactoseFree,
                    newValue,
                  );
            },
            context,
          ),
          _buildSwitchListTile(
            'Vegetarian',
            'Only include vegetarian meals.',
            activeFilters[Filter.vegetarian]!,
            (newValue) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.vegetarian,
                    newValue,
                  );
            },
            context,
          ),
          _buildSwitchListTile(
            'Vegan',
            'Only include vegan meals.',
            activeFilters[Filter.vegan]!,
            (newValue) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.vegan,
                    newValue,
                  );
            },
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue,
      Function(bool) onChange, BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(subtitle,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              )),
      value: currentValue,
      onChanged: onChange,
    );
  }
}
