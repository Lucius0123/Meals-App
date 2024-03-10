import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals =[];
  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message)));
  }
  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting =_favoriteMeals.contains(meal);
    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Meal is removed from Favorite");

    }
    else{
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Marked as Favorite!");

    }
  }
  int _selectPageIndex =0;
  void _selectPage(int index){
    setState(() {
      _selectPageIndex=index;
    });
  }
  void _setScreen(String identifier){
    Navigator.of(context).pop();
    if(identifier=='filters'){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder:(ctx)=>FiltersScreen())
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage =  CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus,);
    var activePageTittle = "Categories";
    if(_selectPageIndex==1){
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,);
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Foverite'),
          ]),
    );
  }
}
