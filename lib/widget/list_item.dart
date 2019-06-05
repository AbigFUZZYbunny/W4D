import 'package:flutter/material.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/utils/double_convert.dart';
import 'package:whats4dinner/utils/string_format.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/colors.dart';

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
            value: dynamicToDouble(this.val),
          ),
        ],
      ),
    );
  }
}

class IngredientListItem extends StatelessWidget {
  final IngredientItem ingredient;
  final Function onPressed;
  final bool isFavorite;

  IngredientListItem(this.ingredient,this.onPressed,this.isFavorite,);

  @override
  Widget build(BuildContext context) {
    String amt = ingredient.measures.us.amount.toString() + " " + ingredient.measures.us.unitShort;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        padding: EdgeInsets.all(Responsiveness.setWidth(context, 10.0)),
        onPressed: this.onPressed(),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: Responsiveness.setHeight(context, 60),
              width: Responsiveness.setWidth(context, 60),
              child: Image.network(
                "https://spoonacular.com/cdn/ingredients_100x100/" + ingredient.image,

              ),
            ),
            SizedBox(width: Responsiveness.setWidth(context, 20.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(capitalizeFirstLetter(ingredient.originalName != null ? ingredient.originalName : ingredient.name), style: Theme.of(context).textTheme.subtitle, overflow: TextOverflow.fade,),
                SizedBox(height: Responsiveness.setHeight(context, 5.0)),
                Text(amt, style: Theme.of(context).textTheme.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SmallEquipmentListItem extends StatelessWidget {
  final Equipment equip;
  final Function onPressed;
  final bool isFavorite;

  SmallEquipmentListItem(this.equip,this.onPressed,this.isFavorite,);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        padding: EdgeInsets.all(Responsiveness.setWidth(context, 10.0)),
        onPressed: this.onPressed,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: Responsiveness.setHeight(context, 30),
              width: Responsiveness.setWidth(context, 30),
              child: Image.network(
                "https://spoonacular.com/cdn/equipment_100x100/" + equip.image,

              ),
            ),
            SizedBox(width: Responsiveness.setWidth(context, 20.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(capitalizeFirstLetter(equip.name), style: Theme.of(context).textTheme.subtitle, overflow: TextOverflow.fade,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class SmallIngredientListItem extends StatelessWidget {
  final IngredientItem ingredient;

  SmallIngredientListItem(this.ingredient,);

  @override
  Widget build(BuildContext context) {
    String txt = capitalizeFirstLetter(ingredient.name);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: Responsiveness.setHeight(context, 30),
              width: Responsiveness.setWidth(context, 30),
              child: Image.network(
                "https://spoonacular.com/cdn/ingredients_100x100/" + ingredient.image,
              ),
            ),
            SizedBox(width: Responsiveness.setWidth(context, 20.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(txt, style: Theme.of(context).textTheme.subtitle, overflow: TextOverflow.clip,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeStepsListItem extends StatelessWidget {
  final RecipeStep recipe;
  final int step;

  RecipeStepsListItem(this.recipe,this.step,);

  @override
  Widget build(BuildContext context) {
    int ndx = step + 1;
    String title (){
      String _ret = "Step " + ndx.toString();
      if(recipe.length != null){
        _ret += " - " + recipe.length.number.toString() + " " + recipe.length.unit;
      }
      return _ret;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsiveness.setHeight(context, 5), horizontal: Responsiveness.setWidth(context, 10)),
      child: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: Responsiveness.setHeight(context, 10), horizontal: Responsiveness.setWidth(context, 15)),
              child: Text(
                title(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: Responsiveness.setHeight(context, 10), horizontal: Responsiveness.setWidth(context, 15)),
                child: Text(
                  recipe.step,
                  style: Theme.of(context).textTheme.caption,
                ),
            ),
            Container(
              //height: dynamicToDouble(recipe.ingredients.length) * Responsiveness.setHeight(context, 55),
              child: getIngredients(recipe),
            ),
          ],
        ),
      ),
    );
  }

  ListView getIngredients(RecipeStep step){
    List<IngredientItem> _ret = new List<IngredientItem>();
    for(var i in step.ingredients){
      _ret.add(i);
    }
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(
        color: LightGray,
      ),
      itemCount: _ret.length,
      itemBuilder: (context, int) {
        return SmallIngredientListItem(_ret[int],);
      },
      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
    );
  }
}