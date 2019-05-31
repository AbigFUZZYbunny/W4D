import 'recipe_item.dart';
import 'preferences.dart';
import 'ingredient_item.dart';
import 'subscription_record.dart';

class User {
  Preferences preferences;
  List<Recipe> schedule;
  List<Recipe> favorites;
  List<SubscriptionRecord> subscription;
  List<IngredientItem> pantry;
  List<IngredientItem> shopping;

  User({
    this.preferences,
    this.schedule,
    this.favorites,
    this.subscription,
    this.pantry,
    this.shopping,
  });

  factory User.newUser() => new User(
    preferences: Preferences.newUser(),
    schedule: new List<Recipe>(),
    favorites: new List<Recipe>(),
    subscription: [SubscriptionRecord.newUser()],
    pantry: new List<IngredientItem>(),
    shopping: new List<IngredientItem>(),
  );
}