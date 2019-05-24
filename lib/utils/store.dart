import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/subscription_record.dart';
import 'package:whats4dinner/models/ingredient_item.dart';

Future<List<Recipe>> getSchedule(String uid) async {
  List<Recipe> _ret = new List<Recipe>();
  QuerySnapshot _sch = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('schedule').getDocuments();
  for(var doc in _sch.documents){
    _ret.add(new Recipe.fromMap(doc.data));
  }
  return _ret;
}

Future<List<Recipe>> getFavorites(String uid) async {
  List<Recipe> _ret = new List<Recipe>();
  QuerySnapshot _fav = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites').getDocuments();
  for(var doc in _fav.documents){
    _ret.add(new Recipe.fromMap(doc.data));
  }
  return _ret;
}

Future<List<SubscriptionRecord>> getSubscription(String uid) async{
  List<SubscriptionRecord> _ret = new List<SubscriptionRecord>();
  QuerySnapshot _sub = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('subscription')
      .getDocuments();
  for (var doc in _sub.documents) {
    _ret.add(new SubscriptionRecord.fromMap(doc.data));
  }
  return _ret;
}

Future<List<IngredientItem>> getRequiredIngredients(String uid) async{
  List<IngredientItem> _ret = new List<IngredientItem>();
  DocumentSnapshot _ing = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('groceries')
      .document('required').get();
  if(_ing.exists) {
    _ing.data.forEach((key, value) => (){
      _ret.add(new IngredientItem.fromMap(value));
    });
  }
  return _ret;
}

Future<List<IngredientItem>> getStockIngredients(String uid) async{
  List<IngredientItem> _ret = new List<IngredientItem>();
  DocumentSnapshot _ing = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('groceries')
      .document('stock').get();
  if(_ing.exists) {
    _ing.data.forEach((key, value) => (){
      _ret.add(new IngredientItem.fromMap(value));
    });
  }
  return _ret;
}

Future<List<IngredientItem>> getShoppingList(String uid) async{
  List<IngredientItem> _ret = new List<IngredientItem>();
  DocumentSnapshot _ing = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('groceries')
      .document('shopping').get();
  if(_ing.exists) {
    _ing.data.forEach((key, value) => (){
      _ret.add(new IngredientItem.fromMap(value));
    });
  }
  return _ret;
}

Future<bool> updateFavoriteMeal(String uid, Recipe recipe) {
  DocumentReference favoritesReference = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites')
      .document(recipe.id.toString());
  CollectionReference favoritesCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites');
  return Firestore.instance.runTransaction((Transaction tx) async {
    DocumentSnapshot postSnapshot = await tx.get(favoritesReference);
    if (postSnapshot.exists) {
      await tx.delete(favoritesReference);
    } else {
      await favoritesCollection.add(recipe.toMap());
    }
  }).then((result) {
    return true;
  }).catchError((error) {
    print('Error: $error');
    return false;
  });
}