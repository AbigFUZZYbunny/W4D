import 'package:flutter/material.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/utils/string_format.dart';

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