import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Provider/meals_provider.dart';
enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}
class FilterNotifier extends StateNotifier<Map<Filter,bool>>{
  FilterNotifier(): super({
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
  });
  void setFilters(Map<Filter,bool>chosenFilter){
    state = chosenFilter;
  }
  void setFilter(Filter filter , bool isActive){
    state ={
      ...state,
  filter: isActive,
  };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier,Map<Filter,bool>>((ref) => FilterNotifier()
);

final filterMealProvider = Provider((ref) {
final meals=  ref.watch(mealsProvider);
final activeFilters=  ref.watch(filterProvider);
  return meals.where((meal) {
    if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }

    if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
    }
    if(activeFilters[Filter.vegan]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();

});