import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  // final Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            meal.title,
            style: const TextStyle(color: Colors.amberAccent),
          ),
          actions: [
            IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProdvider.notifier)
                    .toggleMealFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        wasAdded ? 'Meal added as favorite' : 'Meal removed'),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(microseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.star,
                  key: ValueKey(2),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              ...meal.ingredients
                  .map(
                    (ingredients) => Text(
                      ingredients,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 44),
              Text(
                "Steps",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 12),
              for (final steps in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    steps,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                )
            ],
          ),
        ));
  }
}
