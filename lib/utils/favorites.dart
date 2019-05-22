import 'package:flutter/material.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/models/recipe_item.dart';

class FavoritesFunctions {

  static bool inFavorites(int id, context){
    for(var r in StateWidget.of(context).state.userInfo.favorites.meal){
      if(r.id == id)
        return true;
    }
    return false;
  }

  static void addRemoveFavorite(Recipe r, context){
    if(!inFavorites(r.id, context)){
      StateWidget.of(context).state.userInfo.favorites.meal.add(r);
    }else{
      StateWidget.of(context).state.userInfo.favorites.meal.remove(r);
    }
  }
}