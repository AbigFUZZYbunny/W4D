import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/subscription_record.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/models/preferences.dart';

Future<List<Recipe>> getSchedule(String uid) async {
  return await getRecipes(
      Firestore.instance
          .collection('users')
          .document(uid)
          .collection('schedule')
  ).catchError((error) {
    print('Error: $error');
  });
}
Future<List<Recipe>> getFavorites(String uid) async {
  return await getRecipes(
      Firestore.instance
          .collection('users')
          .document(uid)
          .collection('favorites')
  ).catchError((error) {
    print('Error: $error');
  });
}Future<List<IngredientItem>> getScheduleRecipeIngredients(String uid, String rid) async{
  return await getIngredientsList(
      Firestore.instance
          .collection('users')
          .document(uid)
          .collection('schedule')
          .document(rid)
          .collection('extendedIngredients')
  ).catchError((error) {
    print('Error: $error');
  });
}
Future<List<IngredientItem>> getFavoriteRecipeIngredients(String uid, String rid) async{
  return await getIngredientsList(
      Firestore.instance
          .collection('users')
          .document(uid)
          .collection('favorites')
          .document(rid)
          .collection('extendedIngredients')
  ).catchError((error) {
    print('Error: $error');
  });
}
Future<List<Recipe>> getRecipes(CollectionReference ref) async{
  List<Recipe> _ret = new List<Recipe>();
  await ref
      .getDocuments()
      .then((qs) => () async {
    for (var doc in qs.documents){
      Recipe _rec = new Recipe.fromMap(doc.data);
      _rec.extendedIngredients = await getIngredientsList(ref.document(doc.documentID).collection('extendedIngredients'));
      _ret.add(_rec);
    }
    return _ret;
  }).catchError((error) {
    print('Error: $error');
  });
  return new List<Recipe>();
}
Future<List<SubscriptionRecord>> getSubscription(String uid) async{
  List<SubscriptionRecord> _ret = new List<SubscriptionRecord>();
  await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('subscription')
      .getDocuments().then((qs) {
    for (var doc in qs.documents) {
      _ret.add(new SubscriptionRecord.fromMap(doc.data));
    }
    return _ret;
  }).catchError((error) {
    print('Error: $error');
  });
  return _ret;
}
Future<List<IngredientItem>> getStockIngredients(String uid) async{
  return await getIngredientsList(
      Firestore.instance
          .collection('users')
          .document(uid)
          .collection('pantry')
  ).catchError((error) {
    print('Error: $error');
  });
}
Future<List<IngredientItem>> getShoppingList(String uid) async{
  return await getIngredientsList(
      Firestore.instance
      .collection('users')
      .document(uid)
      .collection('shopping')
  ).catchError((error) {
    print('Error: $error');
  });
}
Future<List<IngredientItem>> getIngredientsList(CollectionReference ref) async{
  List<IngredientItem> _ret = new List<IngredientItem>();
  await ref
      .getDocuments()
      .then((qs) => (){
    for (var doc in qs.documents){
      _ret.add(new IngredientItem.fromMap(doc.data));
    }
    return _ret;
  }).catchError((error) {
    print('Error: $error');
  });
  return _ret;
}
Future<void> updateFavoriteMeal(String uid, Recipe recipe) async {
  CollectionReference favoritesCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites');
  await favoritesCollection.getDocuments().then((qs) => () async {
    for(var doc in qs.documents){
      if(doc.documentID == recipe.id.toString()){
        await Firestore.instance
            .collection('users')
            .document(uid)
            .collection('favorites')
            .document(recipe.id.toString())
            .delete()
            .catchError((error) {
              print('Error: $error');
            });
      }else{
        await favoritesCollection.document(recipe.id.toString()).setData(recipe.toMap());
      }
    }
  }).catchError((error) {
    print('Error: $error');
  });
}
Future<Preferences> getPreferences(String uid) async{
  CollectionReference preferenceCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  Preferences _ret = new Preferences();
  _ret.ingredients = await preferenceCollection.document('ingredients').get().then((ds) {
    return PrefIngredients.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.ingredients.favoriteGroceries = await getIngredientsList(
      preferenceCollection
          .document('ingredients')
          .collection('favorites')
  );
  _ret.allergies = await preferenceCollection.document('allergies').get().then((ds) {
    return Map.from(ds.data).map((k, v) => new MapEntry<String, bool>(k, v));
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.favorites = await preferenceCollection.document('favorites').get().then((ds) {
    return PrefFavorites.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.schedule = await preferenceCollection.document('schedule').get().then((ds) {
    return PrefSchedule.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.notifications = await preferenceCollection.document('notifications').get().then((ds) {
    return PrefNotifications.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.cuisines = await preferenceCollection.document('cuisines').get().then((ds) {
    return PrefCuisines.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.diets = await preferenceCollection.document('diets').get().then((ds) {
    return PrefDiets.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  _ret.nutrition = await preferenceCollection.document('nutrition').get().then((ds) {
    return PrefNutrition.fromMap(ds.data);
  }).catchError((error) {
    print('Error: $error');
  });
  return _ret;
}