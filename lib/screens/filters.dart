import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

// enum Filter { glutenfree, lactoseFree, vegetrain, vegan } //moved into filter provide

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});
  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetrainFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilter = ref.read(filterProvide);
    _glutenFreeFilterSet = activeFilter[Filter.glutenfree]!;
    _lactoseFreeFilterSet = activeFilter[Filter.lactoseFree]!;
    _vegetrainFreeFilterSet = activeFilter[Filter.vegetrain]!;
    _veganFreeFilterSet = activeFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(filterProvide.notifier).setStates({
          Filter.glutenfree: _glutenFreeFilterSet,
          Filter.lactoseFree: _lactoseFreeFilterSet,
          Filter.vegetrain: _vegetrainFreeFilterSet,
          Filter.vegan: _veganFreeFilterSet
        });

        // Navigator.of(context).pop({
        //   Filter.glutenfree: _glutenFreeFilterSet,
        //   Filter.lactoseFree: _lactoseFreeFilterSet,
        //   Filter.vegetrain: _vegetrai  nFreeFilterSet,
        //   Filter.vegan: _veganFreeFilterSet
        // });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Filters"),
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Gluten Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "only includes Gluten Free Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Lactose Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "only includes Lactose Free Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetrainFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetrainFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegetrain",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "only includes vegetrain Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFreeFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "only includes vegan Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              // activeColor: Theme.of(context).colorScheme.tertiary,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
