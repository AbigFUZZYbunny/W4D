// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'recipe_item.dart';
import 'preferences.dart';
import 'ingredient_item.dart';
import 'subscription_record.dart';

class User {
  Preferences preferences;
  Groceries groceries;
  Schedule schedule;
  Favorites favorites;
  List<SubscriptionRecord> subscription;

  User({
    this.preferences,
    this.groceries,
    this.schedule,
    this.favorites,
    this.subscription,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map json) => new User(
    preferences: json["preferences"] == null ? null : Preferences.fromMap(json["preferences"]),
    groceries: json["groceries"] == null ? null : Groceries.fromMap(json["groceries"]),
    schedule: json["schedule"] == null ? null : Schedule.fromMap(json["schedule"]),
    favorites: json["favorites"] == null ? null : Favorites.fromMap(json["favorites"]),
    subscription: json["subscription"] == null ? null : new List<SubscriptionRecord>.from(json["subscription"].map((x) => SubscriptionRecord.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "preferences": preferences == null ? null : preferences.toMap(),
    "groceries": groceries == null ? null : groceries.toMap(),
    "schedule": schedule == null ? null : schedule.toMap(),
    "favorites": favorites == null ? null : favorites.toMap(),
    "subscription": subscription == null ? null : new List<dynamic>.from(subscription.map((x) => x.toMap())),
  };

  factory User.newUser() => new User(
    preferences: Preferences.newUser(),
    groceries: Groceries.newUser(),
    schedule: Schedule.newUser(),
    favorites: Favorites.newUser(),
    subscription: [SubscriptionRecord.newUser()],
  );
}

class Favorites {
  List<Recipe> meal;
  List<Recipe> side;
  List<Recipe> dessert;

  Favorites({
    this.meal,
    this.side,
    this.dessert,
  });

  factory Favorites.fromJson(String str) => Favorites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorites.fromMap(Map json) => new Favorites(
    meal: json["meal"] == null ? null : new List<Recipe>.from(json["meal"].map((x) => Recipe.fromMap(x))),
    side: json["side"] == null ? null : new List<dynamic>.from(json["side"].map((x) => x)),
    dessert: json["dessert"] == null ? null : new List<dynamic>.from(json["dessert"].map((x) => x)),
  );

  factory Favorites.newUser() => new Favorites(
    meal: new List<Recipe>(),
    side: new List<Recipe>(),
    dessert: new List<Recipe>(),
  );

  Map<String, dynamic> toMap() => {
    "meal": meal == null ? null : new List<dynamic>.from(meal.map((x) => x.toMap())),
    "side": side == null ? null : new List<dynamic>.from(side.map((x) => x)),
    "dessert": dessert == null ? null : new List<dynamic>.from(dessert.map((x) => x)),
  };
}

class Groceries {
  List<IngredientItem> required;
  List<IngredientItem> stock;
  List<IngredientItem> shopping;

  Groceries({
    this.required,
    this.stock,
    this.shopping,
  });

  factory Groceries.newUser() => new Groceries(
    required: new List<IngredientItem>(),
    stock: new List<IngredientItem>(),
    shopping: new List<IngredientItem>(),
  );

  factory Groceries.fromJson(String str) => Groceries.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Groceries.fromMap(Map json) => new Groceries(
    required: json["required"] == null ? null : new List<IngredientItem>.from(json["required"].map((x) => IngredientItem.fromMap(x))),
    stock: json["stock"] == null ? null : new List<IngredientItem>.from(json["stock"].map((x) => IngredientItem.fromMap(x))),
    shopping: json["shopping"] == null ? null : new List<IngredientItem>.from(json["shopping"].map((x) => IngredientItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "required": required == null ? null : new List<dynamic>.from(required.map((x) => x.toMap())),
    "stock": stock == null ? null : new List<dynamic>.from(stock.map((x) => x.toMap())),
    "shopping": shopping == null ? null : new List<dynamic>.from(shopping.map((x) => x)),
  };
}

class Schedule {
  List<Recipe> meal;
  List<Recipe> side;
  List<Recipe> dessert;

  Schedule({
    this.meal,
    this.side,
    this.dessert,
  });

  factory Schedule.newUser() => new Schedule(
    meal: new List<Recipe>(),
    side:  new List<Recipe>(),
    dessert:  new List<Recipe>(),
  );

  factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Schedule.fromMap(Map json) => new Schedule(
    meal: json["meal"] == null ? null : new List<Recipe>.from(json["meal"].map((x) => Recipe.fromMap(x))),
    side: json["side"] == null ? null : new List<Recipe>.from(json["side"].map((x) => Recipe.fromMap(x))),
    dessert: json["dessert"] == null ? null : new List<Recipe>.from(json["dessert"].map((x) => Recipe.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "meal": meal == null ? null : new List<dynamic>.from(meal.map((x) => x.toMap())),
    "side": side == null ? null : new List<dynamic>.from(side.map((x) => x)),
    "dessert": dessert == null ? null : new List<dynamic>.from(dessert.map((x) => x)),
  };
}