import 'package:whats4dinner/models/recipe_item.dart';

String getCalories(Recipe meal) {
  for(var n in meal.nutrition.nutrients) {
    if(n.title == "Calories"){
      String _ret = n.amount.toString();
      return _ret;
    }
  }
  return "Unknown";
}
String getCarbs(Recipe meal) {
  for(var n in meal.nutrition.nutrients) {
    if(n.title == "Carbohydrates") {
      String _ret = n.amount.toString() + " " + n.unit;
      return _ret;
    }
  }
  return "Unknown";
}
String getFat(Recipe meal) {
  for(var n in meal.nutrition.nutrients) {
    if(n.title == "Fat") {
      String _ret = n.amount.toString() + " " + n.unit;
      return _ret;
    }
  }
  return "Unknown";
}