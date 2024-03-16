import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Provider/favorites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../Provider/filters_provider.dart';
const kInitialFilter ={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegetarian:false,
  Filter.vegan:false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex =0;
  void _selectPage(int index){
    setState(() {
      _selectPageIndex=index;
    });
  }
  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if(identifier=='filters'){
     await  Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
            builder:(ctx)=>const FiltersScreen())
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealProvider);
    Widget activePage =  CategoriesScreen(
    availableMeals: availableMeals,);
    var activePageTittle = "Categories";
    if(_selectPageIndex==1){
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,);
      activePageTittle ="Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTittle),
      ),
      drawer:MainDrawer(onSelectScreen: _setScreen,),
      body:activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap:_selectPage,
          currentIndex: _selectPageIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star),label: 'favorites'),
          ]),
    );
  }
}
