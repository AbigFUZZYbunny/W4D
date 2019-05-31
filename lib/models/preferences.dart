// To parse this JSON data, do
//
//     final preferences = preferencesFromJson(jsonString);

import 'dart:convert';
import 'ingredient_item.dart';
import 'nutrient.dart';
import 'package:whats4dinner/utils/lists.dart';

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
    filterLevel: json["filterLevel"] == null ? 0 : json["filterLevel"],
    diets: json["diets"] == null ? newDiets() : new Map.from(json["diets"]).map((k, v) => new MapEntry<String, bool>(k, v)),
  );

  Map<String, dynamic> toMap() => {
    "filterLevel": filterLevel == null ? null : filterLevel,
    "diets": diets == null ? newDiets() : new Map.from(diets).map((k, v) => new MapEntry<String, dynamic>(k, v)),
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
    scheduleWeight: json["scheduleWeight"] == null ? 0 : json["scheduleWeight"],
    quickWeight: json["quickWeight"] == null ? 0 : json["quickWeight"],
  );

  Map<String, dynamic> toMap() => {
    "scheduleWeight": scheduleWeight == null ? null : scheduleWeight,
    "quickWeight": quickWeight == null ? null : quickWeight,
  };
}

class PrefIngredients {
  int favoritesFilterLevel;
  String measureUnit;
  List<IngredientItem> favorites;
  List<IngredientItem> ignored;

  PrefIngredients({
    this.favoritesFilterLevel,
    this.favorites,
    this.ignored,
    this.measureUnit,
  });

  factory PrefIngredients.newUser() => PrefIngredients(
    favorites: new List<IngredientItem>(),
    ignored: new List<IngredientItem>(),
    favoritesFilterLevel: 0,
    measureUnit: "us",
  );

  factory PrefIngredients.fromJson(String str) => PrefIngredients.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PrefIngredients.fromMap(Map json) => new PrefIngredients(
    favoritesFilterLevel: json["favoritesFilterLevel"] == null ? 0 : json["favoritesFilterLevel"],
    measureUnit: json["measureUnit"] == null ? "us" : json["measureUnit"],
    favorites: new List<IngredientItem>(),
    ignored: new List<IngredientItem>(),
  );

  Map<String, dynamic> toMap() => {
    "favoritesFilterLevel": favoritesFilterLevel == null ? null : favoritesFilterLevel,
    "measureUnit": measureUnit == null ? null : measureUnit,
    //Need to create the following into a collection in firestore
    /*"favorites": favorites == null ? null : new List<dynamic>.from(favorites.map((x) => x.toMap())),
    "ignored": ignored == null ? null : new List<dynamic>.from(ignored.map((x) => x)),*/
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