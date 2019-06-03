import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/utils/string_format.dart';

class RecipeCard extends StatelessWidget {
  final Recipe meal;
  final bool isFavorite;
  final Function handleFavorite;

  RecipeCard({this.meal,this.isFavorite, this.handleFavorite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Responsiveness.setWidth(context, 15), right: Responsiveness.setWidth(context, 15), top: Responsiveness.setHeight(context, 30), bottom: Responsiveness.setHeight(context, 5)),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    meal.title,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Image.network(
                      meal.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child:
                    RawMaterialButton(
                      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                      onPressed: () => handleFavorite(),
                      child: Icon(
                        // Conditional expression:
                        // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
                        isFavorite == true ? Icons.star : Icons.star_border,
                        color: DarkGray,
                        size: 30,
                      ),
                      elevation: 2.0,
                      fillColor: OffWhite,
                      shape: CircleBorder(),
                    ),
                    top: 20,
                    right: 20,
                  ),
                  Positioned(
                    child:
                    Text(
                      "Credit: " + meal.creditText,
                      style: TextStyle(color: OffWhite),
                    ),
                    bottom: 5,
                    right: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsiveness.setHeight(context, 5)),
            RecipeInfo(meal), // Create the summary information to be shown
            SizedBox(height: Responsiveness.setHeight(context, 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:
                  MaterialButton(
                    height: Responsiveness.setHeight(context, 60),
                    onPressed: () => Navigator.of(context).pushNamed("/mealdetail"),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "More Info",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child:
                  MaterialButton(
                    height: Responsiveness.setHeight(context, 60),
                    onPressed: () => print("Start Meal Pressed"),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Start Meal",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeInfo extends StatelessWidget {
  final Recipe meal;

  RecipeInfo(this.meal);

  double _getCalories() {
    for(var n in meal.nutrition.nutrients) {
      if(n.title == "Calories")
        return n.amount;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return _mealDetails(context);
  }

  Padding _mealDetails(BuildContext context) {
    if (meal != null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsiveness.setWidth(context, 10), vertical: Responsiveness.setHeight(context, 15),),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.timer,
                      size: Responsiveness.setHeight(context, 25),
                      color: DarkGray,
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 10)),
                    Text(
                      meal.readyInMinutes.toString(),
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 5)),
                    Text(
                      "Minutes",
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.format_list_numbered,
                      size: Responsiveness.setHeight(context, 25),
                      color: DarkGray,
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 10)),
                    Text(
                      meal.analyzedInstructions[0].steps.length.toString(),
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 5)),
                    Text(
                      "Steps",
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.fastfood,
                      color: DarkGray,
                      size: Responsiveness.setHeight(context, 25),
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 10)),
                    Text(
                      capitalizeFirstLetter(meal.cuisines[0]),
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 5)),
                    Text(
                      "Cuisine",
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.assessment,
                      size: Responsiveness.setHeight(context, 25),
                      color: DarkGray,
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 10)),
                    Text(
                      _getCalories().toString(),
                    ),
                    SizedBox(height: Responsiveness.setHeight(context, 5)),
                    Text(
                      "Calories",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(),
        ],
      ),
    );
  }
}