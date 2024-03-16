import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Data/dummy_data.dart';

final mealsProvider = Provider((ref){
  return dummyMeals;

});