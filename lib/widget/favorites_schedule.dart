import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final Function onPressed;
  final bool isFavorite;

  RecipeListItem(this.recipe, this.onPressed, this.isFavorite,);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onPressed(recipe),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // We overlap the image and the button by
              // creating a Stack object:
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16.0 / 4.5,
                    child: Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                      onPressed: () => onPressed,//addRemoveFavorite(recipe, context),
                      child: Icon(
                        isFavorite == true ? Icons.favorite : Icons.favorite_border,
                      ),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                    ),
                    top: 2.0,
                    right: 2.0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  // Default value for crossAxisAlignment is CrossAxisAlignment.center.
                  // We want to align title and description of recipes left:
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.title,
                    ),
                    // Empty space:
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 20.0),
                        SizedBox(width: 5.0),
                        Text(
                          recipe.readyInMinutes.toString() + " Minutes",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}