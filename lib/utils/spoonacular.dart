import 'package:whats4dinner/models/preferences.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';
import 'dart:convert';

String url = 'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes';

Future<int> getResultsCount(Preferences _pref, String type) async{
  int ranking = _pref.ingredients.favoritesFilterLevel;
  final mealResponse = await http.get(
    '$url/searchComplex?limitLicense=false&type=$type&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=$ranking' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  if(mealResponse.statusCode == 200) {
    Map js = json.decode(mealResponse.body);
    return js["totalResults"];
  }else {
    print("Error: " + mealResponse.statusCode.toString());
    return 0;
  }
}
Future<Recipe> getRandomRecipe(Preferences _pref) async{
  int ranking = _pref.ingredients.favoritesFilterLevel;
  int res = await getResultsCount(_pref, "main course");
  int offset = Random().nextInt(res);
  final mealResponse = await http.get(
    '$url/searchComplex?limitLicense=false&offset=$offset&type=main course&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=$ranking' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  if(mealResponse.statusCode == 200) {
    Map j = json.decode(mealResponse.body);
    return Recipe.mealFromMap(j["results"][0]);
  }else {
    print("Error: " + mealResponse.statusCode.toString());
    return null;
  }
}
Future<List<Recipe>> getRecipeSchedule(Preferences _pref) async{
  List<Recipe> _ret = new List<Recipe>();
  int ranking = _pref.ingredients.favoritesFilterLevel;
  int number = _pref.schedule.numberOfMeals;
  Random _rand = new Random();
  int res = await getResultsCount(_pref, "main course");
  for(int i = 0; i < number; i++){
    int offset = _rand.nextInt(res);
    final mealResponse = await http.get(
      '$url/searchComplex?limitLicense=false&offset=$offset&type=main course&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=$ranking' + buildParameters(_pref),
      headers: {
        "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
        "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
      },
    ).catchError((error) {
      print('Error: $error');
    });
    if(mealResponse.statusCode == 200) {
      Map j = json.decode(mealResponse.body);
      _ret.add(Recipe.mealFromMap(j["results"][0]));
    }else {
      print("Error: " + mealResponse.statusCode.toString());
    }
  }
  return _ret;
}
Future<Recipe> getRandomSide(Preferences _pref) async{
  int ranking = _pref.ingredients.favoritesFilterLevel;
  final mealResponse = await http.get(
    '$url/searchComplex?limitLicense=false&type=side item&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=$ranking' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  return Recipe.fromJson(mealResponse.body);
}
Future<Recipe> getRandomDessert(Preferences _pref) async{
  int ranking = _pref.ingredients.favoritesFilterLevel;
  final mealResponse = await http.get(
    '$url/searchComplex?limitLicense=false&type=dessert&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&ranking=$ranking' + buildParameters(_pref),
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  return Recipe.fromJson(mealResponse.body);
}
Future<Map<int, String>> convertUnits(ingName, origUnit, amount) async {
  final response = await http.get(
    '$url/convert?ingredientName=$ingName&targetUnit=tablespoon&sourceUnit=$origUnit&sourceAmount=$amount',
    headers: {
      "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key": "FYiUBYqYvfmshCovVjy8PmXhteQbp1E8Ie9jsnTc7qON8jK9mM"
    },
  ).catchError((error) {
    print('Error: $error');
  });
  if(response.statusCode == 200) {
    Map<int,String> _ret = new Map<int,String>();
    Map js = json.decode(response.body);
    _ret.putIfAbsent(js["targetAmount"], () => js["targetUnit"]);
    return _ret;
  }else {
    print(response.statusCode.toString());
    return null;
  }
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
  if(_pref.ingredients.favoritesFilterLevel == 1) {
    for (var ing in _pref.ingredients.favorites) {
      _i.add(ing);
    }
  }else if (_pref.ingredients.favoritesFilterLevel == 0){
    //this will need to loop through the pantry ingredients to create the parameter list

  }
  String favIng = _i.join(", ");
  _i.clear();
  for(var ing in _pref.ingredients.ignored){
    _i.add(ing);
  }
  String ignIng = _i.join(", ");
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
  if(favIng != null && favIng != ""){
    _ret += "&includeIngredients=$favIng";
  }
  if(ignIng != null && ignIng != ""){
    _ret += "&excludeIngredients=$ignIng";
  }
  print("spoonacular: " + _ret);
  return _ret;
}

