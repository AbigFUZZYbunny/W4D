import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/utils/favorites.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function handleFavorite;

  RecipeCard({
    @required this.recipe,
    @required this.handleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 5),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Image.network(
                      recipe.image,
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
                        FavoritesFunctions.inFavorites(recipe.id, context) == true ? Icons.favorite : Icons.favorite_border,
                        color: Color.fromARGB(255, 50, 50, 50),
                        size: 30,
                      ),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                    ),
                    top: 20,
                    right: 20,
                  ),
                  Positioned(
                    child:
                    Text(
                      recipe.creditText,
                      style: TextStyle(color: Colors.white,),
                    ),
                    bottom: 5,
                    right: 10,
                  ),
                ],
              ),
            ),
            //RecipeInfo(meal), // Create the summary information to be shown
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:
                  MaterialButton(
                    height: 60,
                    onPressed: () => Navigator.of(context).pushNamed("/mealdetail"),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "More Details",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child:
                  MaterialButton(
                    height: 60,
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