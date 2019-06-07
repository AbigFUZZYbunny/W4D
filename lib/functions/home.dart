import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/utils/store.dart';

bool inFavorites (BuildContext context, Recipe nextMeal){
  if(StateWidget.of(context).state.favorites != null) {
    for (var r in StateWidget
        .of(context)
        .state
        .favorites) {
      if (r.id == nextMeal.id)
        return true;
    }
  }
  return false;
}

Recipe getNextMeal(BuildContext context){
  if(StateWidget.of(context).state.schedule != null && StateWidget.of(context).state.schedule.length > 0) {
    for (var r in StateWidget
        .of(context)
        .state
        .schedule) {
      if (r.recipeType == "meal") {
        return r;
      }
    }
  }else{

  }
}

void favoritesChanged(BuildContext context, Recipe nextMeal) async {
  await updateFavoriteMeal(StateWidget.of(context).state.user.uid, nextMeal);
  if(!inFavorites(context, nextMeal)){
    StateWidget.of(context).state.favorites.add(nextMeal);
  }else{
    StateWidget.of(context).state.favorites.removeWhere((rec) => rec.id == nextMeal.id);
  }
}