import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/models/recipe_item.dart';

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