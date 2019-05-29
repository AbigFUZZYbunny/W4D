import 'package:whats4dinner/models/recipe_item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class Spoonacular{
  String url = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes';

  Future<Recipe> getRandomRecipe(getSide, getDessert) async{

    final mealResponse = await http.get('$url/searchComplex?type=main+course&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true');
    if(getSide)
      final sideResponse = await http.get('$url/searchComplex?type=side+dish&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true');
    if(getDessert)
      final dessertResponse = await http.get('$url/searchComplex?type=dessert&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true');
  }

  Future<List<Recipe>> getMealSchedule(getSide, getDessert) async{
    final mealResponse = await http.get('$url/searchComplex?type=main+course&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true');
    if(getSide)
      final sideResponse = await http.get('$url/searchComplex?type=side+dish&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true');
    if(getDessert)
      final dessertResponse = await http.get('$url/searchComplex?type=dessert&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true');
  }
}