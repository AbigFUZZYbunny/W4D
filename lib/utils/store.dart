import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/models/recipe_item.dart';

Future<List<Recipe>> getSchedule(String uid) async {
  List<Recipe> _ret = new List<Recipe>();
  QuerySnapshot _sub = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('schedule').getDocuments();
  for(var doc in _sub.documents){
    _ret.add(new Recipe.fromMap(doc.data));
  }
  return _ret;
}

Future<List<Recipe>> getFavorites(String uid) async {
  List<Recipe> _ret = new List<Recipe>();
  QuerySnapshot _sub = await Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites').getDocuments();
  for(var doc in _sub.documents){
    _ret.add(new Recipe.fromMap(doc.data));
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