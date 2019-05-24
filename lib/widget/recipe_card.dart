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
    return GestureDetector(
      onTap: () => print("Tapped!"),
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
                    aspectRatio: 16.0 / 9.0,
                    child: Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
                      onPressed: () => this.handleFavorite,
                      child: Icon(
                        // Conditional expression:
                        // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
                        inFavorites(recipe.id, context) == true ? Icons.favorite : Icons.favorite_border,
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
                          recipe.readyInMinutes.toString(),
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