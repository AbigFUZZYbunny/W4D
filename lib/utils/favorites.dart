import 'package:flutter/material.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/models/recipe_item.dart';

class FavoritesFunctions {

  static Function(int, BuildContext) inFavorites = (id, context) => (){
    for (var r in StateWidget.of(context).state.userInfo.favorites) {
      if (r.id == id)
        return true;
    }
  };

  static Function(Recipe, BuildContext) addRemoveFavorite = (r, context) => (){
    if(!inFavorites(r.id, context)){
      StateWidget.of(context).state.userInfo.favorites.add(r);
    }else{
      StateWidget.of(context).state.userInfo.favorites.removeWhere((rec) => rec.id == r.id);
    }
  };
}