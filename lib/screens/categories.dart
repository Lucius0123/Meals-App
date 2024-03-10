import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meals_app/screens/meals.dart';

import '../Data/dummy_data.dart';
import '../Models/meal.dart';
import '../widgets/category_grid_item.dart';



class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;
  void _selectCategory (BuildContext context, category ){
    final filteredMeal = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx)=>MealsScreen(
              onToggleFavorite: onToggleFavorite,
                title: category.title,
                meals:filteredMeal)
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                category: category,
              onSelectCategory: () { _selectCategory(context,category); },
               )
        ],
      );
  }
}
