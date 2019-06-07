import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/widget/state_widget.dart';

List<Recipe> mealList(BuildContext context){
  List<Recipe> _ret = new List<Recipe>();
  for(var r in StateWidget.of(context).state.schedule){
    if(r.recipeType == "meal"){
      _ret.add(r);
    }
  }
  return _ret;
}
List<Recipe> sideList(BuildContext context){
  List<Recipe> _ret = new List<Recipe>();
  for(var r in StateWidget.of(context).state.schedule){
    if(r.recipeType == "side"){
      _ret.add(r);
    }
  }
  return _ret;
}
List<Recipe> dessertList(BuildContext context){
  List<Recipe> _ret = new List<Recipe>();
  for(var r in StateWidget.of(context).state.schedule){
    if(r.recipeType == "dessert"){
      _ret.add(r);
    }
  }
  return _ret;
}
bool inFavorites (Recipe r, BuildContext context){
  if(StateWidget.of(context).state.favorites != null) {
    for (var r in StateWidget
        .of(context)
        .state
        .favorites) {
      if (r.id == r.id)
        return true;
    }
  }
  return false;
}