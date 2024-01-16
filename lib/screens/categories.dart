import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableFMeals});
  // final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableFMeals;
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationCOntroller;

  @override
  void initState() {
    super.initState();
    _animationCOntroller = AnimationController(
        vsync: this,
        duration: const Duration(microseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationCOntroller.forward();
  }

  @override
  void dispose() {
    _animationCOntroller.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filterMeals = widget.availableFMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreena(
          title: category.title,
          meals: filterMeals,
          // onToggleFavorite: onToggleFavorite
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationCOntroller,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // ...availableCategories.map((category) => CategoryGridItems(category: category))
          for (final category in availableCategories)
            CategoryGridItems(
              category: category,
              onSelectedCategory: () {
                _selectedCategory(context, category);
              },
            )
        ],
      ),
      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(
      //     top: 100-_animationCOntroller.value * 100,
      //   ),
      //   child: child,
      // ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationCOntroller, curve: Curves.bounceIn),
        ),
        child: child,
      ),
    );
  }
}
