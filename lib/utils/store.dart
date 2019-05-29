import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/subscription_record.dart';
import 'package:whats4dinner/models/ingredient_item.dart';

Future<List<Recipe>> getSchedule(String uid) async {
  List<Recipe> _ret = new List<Recipe>();
  await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('schedule')
      .getDocuments().then((qs) {
    for (var doc in qs.documents) {
      _ret.add(new Recipe.fromMap(doc.data));
    }
    return _ret;
  });
  return _ret;
}

Future<List<Recipe>> getFavorites(String uid) async {
  List<Recipe> _ret = new List<Recipe>();
  await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites')
      .getDocuments().then((qs) {
    for (var doc in qs.documents) {
      _ret.add(new Recipe.fromMap(doc.data));
    }
    return _ret;
  });
  return _ret;
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
  });
  return _ret;
}

Future<List<IngredientItem>> getStockIngredients(String uid) async{
  List<IngredientItem> _ret = new List<IngredientItem>();
  await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('stock')
      .getDocuments().then((qs) {
    for (var doc in qs.documents){
      _ret.add(new IngredientItem.fromMap(doc.data));
    }
    return _ret;
  });
  return _ret;
}

Future<List<IngredientItem>> getShoppingList(String uid) async{
  List<IngredientItem> _ret = new List<IngredientItem>();
  await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('shopping')
      .getDocuments().then((qs) {
    for (var doc in qs.documents){
      _ret.add(new IngredientItem.fromMap(doc.data));
    }
    return _ret;
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
            .delete();
      }else{
        await favoritesCollection.add(recipe.toMap());
      }
    }
  }).catchError((error) {
    print('Error: $error');
  });
}