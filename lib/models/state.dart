import 'user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'recipe_item.dart';
import 'preferences.dart';
import 'ingredient_item.dart';
import 'subscription_record.dart';

class StateModel{
  bool isLoading;
  User userInfo;
  FirebaseUser user;
  String loadingStatus;
  Preferences preferences;
  List<Recipe> schedule;
  List<Recipe> favorites;
  List<SubscriptionRecord> subscription;
  List<IngredientItem> pantry;
  List<IngredientItem> shopping;

  StateModel({
    this.isLoading = false,
    this.user,
    this.userInfo,
    this.loadingStatus = "",
    this.preferences,
    this.schedule,
    this.favorites,
    this.subscription,
    this.pantry,
    this.shopping,
  });
}