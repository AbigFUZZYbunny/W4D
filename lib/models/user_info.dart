import 'dart:convert';
import 'recipe_item.dart';
import 'preferences.dart';
import 'ingredient_item.dart';
import 'subscription_record.dart';

class User {
  Preferences preferences;
  List<Recipe> schedule;
  List<Recipe> favorites;
  List<SubscriptionRecord> subscription;
  List<IngredientItem> requiredGroceries;
  List<IngredientItem> stockGroceries;
  List<IngredientItem> shoppingList;

  User({
    this.preferences,
    this.schedule,
    this.favorites,
    this.subscription,
    this.stockGroceries,
    this.shoppingList,
    this.requiredGroceries,
  });

  factory User.newUser() => new User(
    preferences: Preferences.newUser(),
    schedule: new List<Recipe>(),
    favorites: new List<Recipe>(),
    subscription: [SubscriptionRecord.newUser()],
    requiredGroceries: new List<IngredientItem>(),
    stockGroceries: new List<IngredientItem>(),
    shoppingList: new List<IngredientItem>(),
  );
}