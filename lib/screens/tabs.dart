import 'package:flutter/material.dart';
// import 'package:meals/data/dummy_data.dart';
// import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart'; //import to provide Filter, must to be provided

const kInitiakFilters = {
  Filter.glutenfree: false,
  Filter.lactoseFree: false,
  Filter.vegetrain: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  //must need to use ConsumerState if want to use provide
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Color startInfoMessageBackgroundColor = Colors.black;

  // final List<Meal> _favoriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitiakFilters;

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   //adding wishlist
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       _showInfoMessage('Meal is no longer a favorite');
  //       startInfoMessageBackgroundColor = Colors.green;
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('you have added favorite item');
  //       startInfoMessageBackgroundColor = Colors
  //           .red; // must have to wrap with setstate to remove items from whislist immedite
  //     });
  //   }
  // }

  void _setScreen(String indetifier) async {
    Navigator.of(context).pop();
    if (indetifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableFMeals = meals.where((meal) {
      final activeFilter = ref.watch(filterProvide);
      if (activeFilter[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilter[Filter.vegetrain]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
        // onToggleFavorite: _toggleMealFavoriteStatus,
        availableFMeals: availableFMeals);
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProdvider);

      activePage = MealsScreena(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your Favorite";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
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
