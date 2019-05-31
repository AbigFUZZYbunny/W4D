import 'package:whats4dinner/models/preferences.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';

String url = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes';

Future<Recipe> getRandomRecipe(Preferences _pref) async{
  final mealResponse = await http.get(
    '$url/searchComplex?type=main+course&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=1' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  return Recipe.fromSpoonacular(mealResponse.body);
}

Future<Recipe> getRandomSide(Preferences _pref) async{
  final mealResponse = await http.get(
    '$url/searchComplex?type=side+item&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=1' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  return Recipe.fromSpoonacular(mealResponse.body);
}

Future<Recipe> getRandomDessert(Preferences _pref) async{
  final mealResponse = await http.get(
    '$url/searchComplex?type=dessert&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=1' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  return Recipe.fromSpoonacular(mealResponse.body);
}

String buildParameters(Preferences _pref){
  String _ret = "";
  String cuisines = "";
  if(Random().nextInt(100) < _pref.cuisines.cuisineWeight) {
    cuisines = _pref.cuisines.favorites[Random().nextInt(_pref.cuisines.favorites.length)];
  }
  List<String> _i = new List<String>();
  _pref.allergies.forEach((k, v) => (){
    if(v){
      _i.add(k);
    }
  });
  String intol = _i.join(", ");
  _i.clear();
  _pref.diets.diets.forEach((k, v) => (){
    if(v){
      _i.add(k);
    }
  });
  String diet = _i.join(", ");
  _i.clear();
  for(var ing in _pref.ingredients.favorites){
    _i.add(ing.name);
  }
  String fav = _i.join(", ");
  _i.clear();
  for(var ing in _pref.ingredients.ignored){
    _i.add(ing.name);
  }
  String ign = _i.join(", ");
  _i.clear();

  if(cuisines != null && cuisines != ""){
    _ret += "&cuisine=$cuisines";
  }
  if(intol != null && intol != ""){
    _ret += "&intolerances=$intol";
  }
  if(diet != null && diet != ""){
    _ret += "&diet=$diet";
  }
  if(fav != null && fav != ""){
    _ret += "&includeIngredients=$fav";
  }
  if(ign != null && ign != ""){
    _ret += "&excludeIngredients=$ign";
  }
  print(_ret);
  return _ret;
}

