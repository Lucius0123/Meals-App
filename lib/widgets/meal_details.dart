import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Provider/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen ({super.key,
    required this.meal,
    });
  final Meal meal;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
              onPressed: (){
              final wasAdded= ref.read(favoriteMealsProvider.notifier)
                   .toggleMealFavoriteStatus(meal);
               ScaffoldMessenger.of(context).clearSnackBars();
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                   content: Text(wasAdded? 'Meal added as a favorite':'Meal removed')));
              },
              icon:AnimatedSwitcher(
                transitionBuilder:(child,animation){
                  return RotationTransition(
                      turns: Tween(
                        begin: 0.8,
                        end: 1.0
                      ).animate(animation),
                    child: child,);
                } ,
                duration: Duration(milliseconds: 300),
                child:Icon(isFavorite?Icons.star:Icons.star_border,key: ValueKey(isFavorite),))
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(meal.imageUrl,
                width: double.infinity,
                 height: 300 ,
                fit: BoxFit.cover,),
            ),
            const SizedBox(
              height: 14,
            ),
            Text("Ingredients",style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.
                bold
            ),),
            const SizedBox(height: 14,),
            for(final ingredient in meal.ingredients)
              Text(ingredient,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),),
            const SizedBox(height: 24,),
            Text("Steps",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.
                bold
            ),),
            const SizedBox(height: 14,),
            for(final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:12,vertical: 8 ),
                child: Text(step,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),),
              ),
          ],
        ),
      ),
    );
  }
}

