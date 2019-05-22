import 'package:flutter/material.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/utils/double_convert.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/utils/favorites.dart';

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String caption;
  final String description;
  final Function onPressed;

  SettingsButton(this.icon, this.title, this.caption, this.onPressed, this.description);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(Responsiveness.setWidth(context, 10.0)),
      onPressed: this.onPressed,
      child: Row(
        children: <Widget>[
          Icon(this.icon),
          SizedBox(width: Responsiveness.setWidth(context, 20.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.title, style: Theme.of(context).textTheme.title),
              SizedBox(height: Responsiveness.setHeight(context, 5.0)),
              Text(this.caption, style: Theme.of(context).textTheme.subtitle),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsToggle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String caption;
  final bool state;
  final Function onChanged;

  SettingsToggle(this.icon, this.title, this.caption, this.state, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsiveness.setWidth(context, 10.0)),
      child: Row(
        children: <Widget>[
          Icon(this.icon),
          SizedBox(width: Responsiveness.setWidth(context, 20.0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.title, style: Theme.of(context).textTheme.title),
                SizedBox(height: Responsiveness.setHeight(context, 5.0)),
                Text(this.caption, style: Theme.of(context).textTheme.subtitle),
              ],
            ),
          ),
          Switch(
            onChanged: this.onChanged,
            value: this.state,
          ),
        ],
      ),
    );
  }
}

class SettingsFilter extends StatelessWidget {
  final String title;
  final String caption;
  final int val;
  final Function onChanged;

  SettingsFilter(this.title, this.caption, this.val, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsiveness.setWidth(context, 10.0)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.title, style: Theme.of(context).textTheme.title),
                    SizedBox(height: Responsiveness.setHeight(context, 5.0)),
                    Text(this.caption, style: Theme.of(context).textTheme.subtitle),
                  ],
                ),
              ),
              Text(this.val.toString(), style: Theme.of(context).textTheme.subtitle, textAlign: TextAlign.end,),
            ],
          ),
          SizedBox(height: Responsiveness.setHeight(context, 5.0)),
          Slider(
            onChanged: this.onChanged,
            min: 0,
            max: 100,
            divisions: 20,
            value: Converter.dynamicToDouble(this.val),
          ),
        ],
      ),
    );
  }
}

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;
  final Function(Recipe) onPressed;

  RecipeListItem(this.recipe, this.onPressed,);

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
                      onPressed: () => FavoritesFunctions.addRemoveFavorite(recipe.id),
                      child: Icon(
                        FavoritesFunctions.inFavorites(recipe.id) == true ? Icons.favorite : Icons.favorite_border,
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