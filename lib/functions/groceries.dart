import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:flutter/material.dart';

//all the regular pantry items like water, salt, pepper, etc...
final List<int> exclusionList = [14412,1102047,2047,1082047,1012047,1002030];

List<IngredientItem> shoppingList(BuildContext context) {
  List<IngredientItem> _ret = new List<IngredientItem>();
  for (var r in StateWidget
      .of(context)
      .state
      .shopping) {
    _ret.add(r);
  }
  return _ret;
}
List<IngredientItem> pantryList(BuildContext context) {
  List<IngredientItem> _ret = new List<IngredientItem>();
  for (var r in StateWidget
      .of(context)
      .state
      .pantry) {
    _ret.add(r);
  }
  return _ret;
}
List<IngredientItem> requiredList(BuildContext context) {
  List<IngredientItem> _ret = new List<IngredientItem>();
  for (var r in StateWidget
      .of(context)
      .state
      .schedule) {
    for (var i in r.extendedIngredients) {
      IngredientItem temp = i;
      if (_ret.length > 0) {
        for (var _i in _ret) {
          if (_i.id == i.id) {
            temp.measures.us.amount += _i.measures.us.amount;
            temp.measures.metric.amount += _i.measures.metric.amount;
            _ret.remove(_i);
          }
        }
      }
      for (var _i in StateWidget
          .of(context)
          .state
          .pantry) {
        if (temp.id == _i.id) {
          temp.measures.us.amount -= _i.measures.us.amount;
          if (temp.measures.us.amount <= 0)
            temp = null;
        }
      }
      if (temp != null && !exclusionList.contains(temp.id))
        _ret.add(temp);
    }
  }
  return _ret;
}