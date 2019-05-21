// To parse this JSON data, do
//
//     final preferences = preferencesFromJson(jsonString);

import 'dart:convert';
import 'ingredient_item.dart';
import 'nutrient.dart';

class Preferences {
  PrefNotifications notifications;
  PrefSchedule schedule;
  PrefFavorites favorites;
  PrefCuisines cuisines;
  Map<String, bool> allergies;
  PrefDiets diets;
  PrefNutrition nutrition;
  PrefIngredients ingredients;

  Preferences({
    this.notifications,
    this.schedule,
    this.favorites,
    this.cuisines,
    this.allergies,
    this.diets,
    this.nutrition,
    this.ingredients,
  });

  factory Preferences.newUser() => new Preferences(
    notifications: PrefNotifications.newUser(),
    schedule: PrefSchedule.newUser(),
    favorites: PrefFavorites.newUser(),
    cuisines: PrefCuisines.newUser(),
    allergies: newAllergies(),
    diets: PrefDiets.newUser(),
    nutrition: PrefNutrition.newUser(),
    ingredients: PrefIngredients.newUser(),
  );

  factory Preferences.fromJson(String str) => Preferences.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Preferences.fromMap(Map json) => new Preferences(
    notifications: json["notifications"] == null ? null : PrefNotifications.fromMap(json["notifications"]),
    schedule: json["schedule"] == null ? null : PrefSchedule.fromMap(json["schedule"]),
    favorites: json["favorites"] == null ? null : PrefFavorites.fromMap(json["favorites"]),
    cuisines: json["cuisines"] == null ? null : PrefCuisines.fromMap(json["cuisines"]),
    allergies: json["allergies"] == null ? null : new Map.from(json["allergies"]).map((k, v) => new MapEntry<String, bool>(k, v)),
    diets: json["diets"] == null ? null : PrefDiets.fromMap(json["diets"]),
    nutrition: json["nutrition"] == null ? null : PrefNutrition.fromMap(json["nutrition"]),
    ingredients: json["ingredients"] == null ? null : PrefIngredients.fromMap(json["ingredients"]),
  );

  Map<String, dynamic> toMap() => {
    "notifications": notifications == null ? null : notifications.toMap(),
    "schedule": schedule == null ? null : schedule.toMap(),
    "favorites": favorites == null ? null : favorites.toMap(),
    "cuisines": cuisines == null ? null : cuisines.toMap(),
    "allergies": allergies == null ? null : new Map.from(allergies).map((k, v) => new MapEntry<String, dynamic>(k, v)),
    "diets": diets == null ? null : diets.toMap(),
    "nutrition": nutrition == null ? null : nutrition.toMap(),
    "ingredients": ingredients == null ? null : ingredients.toMap(),
  };
}

class PrefCuisines {
  int cuisineWeight;
  List<String> favorites;
  List<String> ignored;

  PrefCuisines({
    this.cuisineWeight,
    this.favorites,
    this.ignored
  });

  factory PrefCuisines.newUser() => new PrefCuisines(
    ignored: new List<String>(),
    favorites: new List<String>(),
    cuisineWeight: 0,
  );

  factory PrefCuisines.fromJson(String str) => PrefCuisines.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefCuisines.fromMap(Map json) => new PrefCuisines(
    cuisineWeight: json["cuisineWeight"] == null ? null : json["cuisineWeight"],
    favorites: json["favorites"] == null ? null : new List<String>.from(json["favorites"].map((x) => x)),
    ignored: json["ignored"] == null ? null : new List<String>.from(json["ignored"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "cuisineWeight": cuisineWeight == null ? null : cuisineWeight,
    "favorites": favorites == null ? null : new List<dynamic>.from(favorites.map((x) => x)),
    "ignored": ignored == null ? null : new List<dynamic>.from(ignored.map((x) => x)),
  };
}

class PrefDiets {
  int filterLevel;
  Map<String, bool> diets;

  PrefDiets({
    this.filterLevel,
    this.diets,
  });

  factory PrefDiets.newUser() => new PrefDiets(
    filterLevel: 0,
    diets: newDiets(),
  );

  factory PrefDiets.fromJson(String str) => PrefDiets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefDiets.fromMap(Map json) => new PrefDiets(
    filterLevel: json["filterLevel"] == null ? null : json["filterLevel"],
    diets: json["diets"] == null ? null : new Map.from(json["diets"]).map((k, v) => new MapEntry<String, dynamic>(k, v)),
  );

  Map<String, dynamic> toMap() => {
    "filterLevel": filterLevel == null ? null : filterLevel,
    "diets": diets == null ? null : new Map.from(diets).map((k, v) => new MapEntry<String, dynamic>(k, v)),
  };
}

class PrefFavorites {
  int scheduleWeight;
  int quickWeight;

  PrefFavorites({
    this.scheduleWeight,
    this.quickWeight,
  });

  factory PrefFavorites.newUser() => PrefFavorites(
    scheduleWeight: 5,
    quickWeight: 10,
  );

  factory PrefFavorites.fromJson(String str) => PrefFavorites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefFavorites.fromMap(Map json) => new PrefFavorites(
    scheduleWeight: json["scheduleWeight"] == null ? null : json["scheduleWeight"],
    quickWeight: json["quickWeight"] == null ? null : json["quickWeight"],
  );

  Map<String, dynamic> toMap() => {
    "scheduleWeight": scheduleWeight == null ? null : scheduleWeight,
    "quickWeight": quickWeight == null ? null : quickWeight,
  };
}

class PrefIngredients {
  int favoritesFilterLevel;
  List<IngredientItem> favorites;
  List<IngredientItem> ignored;

  PrefIngredients({
    this.favoritesFilterLevel,
    this.favorites,
    this.ignored,
  });

  factory PrefIngredients.newUser() => PrefIngredients(
    favorites: new List<IngredientItem>(),
    ignored: new List<IngredientItem>(),
    favoritesFilterLevel: 0,
  );

  factory PrefIngredients.fromJson(String str) => PrefIngredients.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefIngredients.fromMap(Map json) => new PrefIngredients(
    favoritesFilterLevel: json["favoritesFilterLevel"] == null ? null : json["favoritesFilterLevel"],
    favorites: json["favorites"] == null ? null : new List<IngredientItem>.from(json["favorites"].map((x) => IngredientItem.fromMap(x))),
    ignored: json["ignored"] == null ? null : new List<IngredientItem>.from(json["ignored"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "favoritesFilterLevel": favoritesFilterLevel == null ? null : favoritesFilterLevel,
    "favorites": favorites == null ? null : new List<dynamic>.from(favorites.map((x) => x.toMap())),
    "ignored": ignored == null ? null : new List<dynamic>.from(ignored.map((x) => x)),
  };
}

class PrefNotifications {
  bool mealStart;
  bool dinnerBell;
  List<String> dinnerBellSms;
  String dinnerBellTxt;
  bool newRecommendations;
  bool expiration;

  PrefNotifications({
    this.mealStart,
    this.dinnerBell,
    this.dinnerBellSms,
    this.dinnerBellTxt,
    this.newRecommendations,
    this.expiration,
  });

  factory PrefNotifications.newUser() => new PrefNotifications(
    mealStart: false,
    dinnerBellTxt: "Time for Dinner.",
    dinnerBellSms: new List<String>(),
    newRecommendations: false,
    expiration: false,
  );

  factory PrefNotifications.fromJson(String str) => PrefNotifications.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefNotifications.fromMap(Map json) => new PrefNotifications(
    mealStart: json["dinnerStart"] == null ? null : json["dinnerStart"],
    dinnerBell: json["dinnerBell"] == null ? null : json["dinnerBell"],
    dinnerBellSms: json["dinnerBellSMS"] == null ? null : new List<String>.from(json["dinnerBellSMS"].map((x) => x)),
    dinnerBellTxt: json["dinnerBellTxt"] == null ? null : json["dinnerBellTxt"],
    newRecommendations: json["newRecommendations"] == null ? null : json["newRecommendations"],
    expiration: json["expiration"] == null ? null : json["expiration"],
  );

  Map<String, dynamic> toMap() => {
    "dinnerStart": mealStart == null ? null : mealStart,
    "dinnerBell": dinnerBell == null ? null : dinnerBell,
    "dinnerBellSMS": dinnerBellSms == null ? null : new List<dynamic>.from(dinnerBellSms.map((x) => x)),
    "dinnerBellTxt": dinnerBellTxt == null ? null : dinnerBellTxt,
    "newRecommendations": newRecommendations == null ? null : newRecommendations,
    "expiration": expiration == null ? null : expiration,
  };
}

class PrefNutrition {
  String preset;
  int filterLevel;
  List<Nutrient> nutrients;

  PrefNutrition({
    this.preset,
    this.filterLevel,
    this.nutrients,
  });

  factory PrefNutrition.newUser() => new PrefNutrition(
    preset: null,
    filterLevel: 0,
    nutrients: newNutrients(),
  );

  factory PrefNutrition.fromJson(String str) => PrefNutrition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefNutrition.fromMap(Map json) => new PrefNutrition(
    preset: json["preset"] == null ? null : json["preset"],
    filterLevel: json["filterLevel"] == null ? null : json["filterLevel"],
    nutrients: json["nutrients"] == null ? null : new List<Nutrient>.from(json["nutrients"].map((x) => Nutrient.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "preset": preset == null ? null : preset,
    "filterLevel": filterLevel == null ? null : filterLevel,
    "nutrients": nutrients == null ? null : new List<dynamic>.from(nutrients.map((x) => x.toMap())),
  };
}

class PrefSchedule {
  bool sideDishes;
  int sideDishDifficulty;
  bool dessert;
  int dessertDifficulty;
  int servings;
  bool populateCalendar;
  DateTime mealTime;

  PrefSchedule({
    this.sideDishes,
    this.sideDishDifficulty,
    this.dessert,
    this.dessertDifficulty,
    this.servings,
    this.populateCalendar,
    this.mealTime,
  });

  factory PrefSchedule.newUser() => new PrefSchedule(
    sideDishDifficulty: 2,
    sideDishes: true,
    dessert: false,
    dessertDifficulty: 2,
    servings: 2,
    populateCalendar: false,
    mealTime: DateTime.parse("1900-01-01 18:30:00Z"),
  );

  factory PrefSchedule.fromJson(String str) => PrefSchedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefSchedule.fromMap(Map json) => new PrefSchedule(
    sideDishes: json["sideDishes"] == null ? null : json["sideDishes"],
    sideDishDifficulty: json["sideDishDifficulty"] == null ? null : json["sideDishDifficulty"],
    dessert: json["dessert"] == null ? null : json["dessert"],
    dessertDifficulty: json["dessertDifficulty"] == null ? null : json["dessertDifficulty"],
    servings: json["servings"] == null ? null : json["servings"],
    populateCalendar: json["populateCalendar"] == null ? null : json["populateCalendar"],
    mealTime: json["mealTime"] == null ? null : DateTime.parse(json["mealTime"]),
  );

  Map<String, dynamic> toMap() => {
    "sideDishes": sideDishes == null ? null : sideDishes,
    "sideDishDifficulty": sideDishDifficulty == null ? null : sideDishDifficulty,
    "dessert": dessert == null ? null : dessert,
    "dessertDifficulty": dessertDifficulty == null ? null : dessertDifficulty,
    "servings": servings == null ? null : servings,
    "populateCalendar": populateCalendar == null ? null : populateCalendar,
    "mealTime": mealTime == null ? null : mealTime.toIso8601String(),
  };
}

List<Nutrient> newNutrients(){
  List<Nutrient> _ret = new List<Nutrient>();
  nutrientsList().forEach((key, value) => (){
    _ret.add(new Nutrient.newUser(key, value));
  });
  return _ret;
}

Map<String, bool> newDiets(){
  Map<String, bool> _ret = new Map<String, bool>();
  for (var i in dietsList()){
    _ret.putIfAbsent(i, () => false);
  }
  return _ret;
}

Map<String, bool> newAllergies(){
  Map<String, bool> _ret = new Map<String, bool>();
  for (var i in allergyList()){
    _ret.putIfAbsent(i, () => false);
  }
  return _ret;
}

List<String> dietsList(){
  List<String> _ret = ["pescetarian", "lacto vegetarian", "ovo vegetarian", "vegan", "paleo", "primal", "vegetarian"];
  return _ret;
}

List<String> allergyList(){
  List<String> _ret = ["dairy", "egg", "gluten", "peanut", "sesame", "seafood", "shellfish", "soy", "sulfite", "tree nut", "wheat"];
  return _ret;
}

List<String> cuisineList(){
  List<String> _ret = [ "African", "American", "British", "Cajun", "Caribbean", "Chinese", "Eastern European", "French", "German", "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish", "Korean", "Latin American", "Mexican", "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"];
  return _ret;
}

Map<String, String> nutrientsList(){
  Map<String, String> _ret = {
    "Calories": "cal",
    "Fat": "g",
    "Protein": "g",
    "Carbs": "g",
    "Alcohol": "g",
    "Caffeine": "mg",
    "Copper": "mg",
    "Calcium": "mg",
    "Choline": "mg",
    "Cholesterol": "mg",
    "Fluoride": "mg",
    "Saturated Fat": "g",
    "Vitamin A": "IU",
    "Vitamin C": "mg",
    "Vitamin D": "µg",
    "Vitamin E": "mg",
    "Vitamin K": "µg",
    "Vitamin B1": "mg",
    "Vitamin B2": "mg",
    "Vitamin B3": "mg",
    "Vitamin B5": "mg",
    "Vitamin B6": "mg",
    "Vitamin B12": "µg",
    "Fiber": "mg",
    "Folate": "g",
    "Folic Acid": "g",
    "Iodine": "g",
    "Iron": "mg",
    "Magnesium": "mg",
    "Manganese": "mg",
    "Phosphorus": "mg",
    "Potassium": "mg",
    "Selenium": "g",
    "Sodium": "mg",
    "Sugar": "mg",
    "Zinc": "mg"
  };
  return _ret;
}
