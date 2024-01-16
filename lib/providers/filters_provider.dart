import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenfree,
  lactoseFree,
  vegetrain,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactoseFree: false,
          Filter.vegetrain: false,
          Filter.vegan: false
        });

  void setStates(Map<Filter, bool> choosenFilter ){
   state = choosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    // setFilter[filter] = isActive; //not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvide = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
    (ref) => FiltersNotifier());
