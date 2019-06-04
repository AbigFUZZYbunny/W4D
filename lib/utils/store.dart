import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/subscription_record.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/models/preferences.dart';

Future<void> putSchedule(String uid, List<Recipe> rec) async{
  CollectionReference scheduleCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('schedule');
  for(var r in rec) {
    await scheduleCollection.document(r.id.toString()).setData(r.toMap());
  }
}
Future<void> putAllPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('schedule').setData(pref.schedule.toMap());
  await prefCollection.document('notifications').setData(pref.notifications.toMap());
  await prefCollection.document('favorites').setData(pref.favorites.toMap());
  await prefCollection.document('allergies').setData(pref.allergies);
  await prefCollection.document('diets').setData(pref.diets.toMap());
  await prefCollection.document('cuisines').setData(pref.cuisines.toMap());
  //await prefCollection.document('general').setData(pref.general.toMap());
  await prefCollection.document('ingredients').setData(pref.ingredients.toMap());
  await prefCollection.document('nutrition').setData(pref.nutrition.toMap());
}
Future<void> putSchedulePreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('schedule').setData(pref.schedule.toMap());
}
Future<void> putNotificationPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('notifications').setData(pref.notifications.toMap());
}
Future<void> putFavoritesPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('favorites').setData(pref.favorites.toMap());
}
Future<void> putAllergiesPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('allergies').setData(pref.allergies);
}
Future<void> putDietsPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('diets').setData(pref.diets.toMap());
}
Future<void> putCuisinesPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('cuisines').setData(pref.cuisines.toMap());
}
Future<void> putIngredientPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('ingredients').setData(pref.ingredients.toMap());
}
Future<void> putNutritionPreferences(String uid, Preferences pref) async{
  CollectionReference prefCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('preferences');
  await prefCollection.document('nutrition').setData(pref.nutrition.toMap());
}
Future<List<Recipe>> getRecipes(CollectionReference ref) async {
  List<Recipe> _ret = new List<Recipe>();
  QuerySnapshot qs = await ref
      .getDocuments();
  for (var doc in qs.documents) {
    Recipe _rec = new Recipe.fromMap(doc.data);
    await ref
        .document(doc.documentID)
        .collection("extendedIngredients")
        .getDocuments()
        .then((qr) {
      for (var docs in qr.documents) {
        _rec.extendedIngredients.add(new IngredientItem.fromMap(docs.data));
      }
      _ret.add(_rec);
    });
  }
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
  print("updateFavoriteMeal");
  CollectionReference favoritesCollection = Firestore.instance
      .collection('users')
      .document(uid)
      .collection('favorites');
  QuerySnapshot qs = await favoritesCollection.getDocuments();
  if(qs.documents.length > 0) {
    for (var doc in qs.documents) {
      if (doc.documentID == recipe.id.toString()) {
        for(var i in recipe.extendedIngredients)
          await Firestore.instance
              .collection('users')
              .document(uid)
              .collection('favorites')
              .document(recipe.id.toString())
              .collection('extendedIngredients')
              .document(i.id.toString())
              .delete();
        await Firestore.instance
            .collection('users')
            .document(uid)
            .collection('favorites')
            .document(recipe.id.toString())
            .delete()
            .catchError((error) {
          print('Error: $error');
        });
        print("favorite removed from firestore");
        return false;
      }
    }
    await favoritesCollection.document(recipe.id.toString()).setData(recipe.toMap());
    for(var i in recipe.extendedIngredients)
      await favoritesCollection
          .document(recipe.id.toString())
          .collection('extendedIngredients')
          .document(i.id.toString())
          .setData(i.toMap());
    print("favorite added to firestore");
    return true;
  }else {
    await favoritesCollection.document(recipe.id.toString()).setData(recipe.toMap());
    for(var i in recipe.extendedIngredients)
      await favoritesCollection
          .document(recipe.id.toString())
          .collection('extendedIngredients')
          .document(i.id.toString())
          .setData(i.toMap());
    print("favorite added to firestore");
    return true;
  }
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