import 'package:flutter/material.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/utils/string_format.dart';

class RequiredListItem extends StatelessWidget {
  final IngredientItem ingredient;

  RequiredListItem(this.ingredient,);

  @override
  Widget build(BuildContext context) {
    String amt = ingredient.measures.us.amount.toString() + " " + ingredient.measures.us.unitShort;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context)  {
            return new AlertDialog(
              title: Text(
                capitalizeFirstLetter(ingredient.originalName),
                textAlign: TextAlign.center,
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("Add to shopping list"),
                        ),
                      ),
                    ]
                  ),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text("Already have this ingredient"),
                          ),
                        ),
                      ]
                  ),

                ],
              ),
            );
          },
        ),
        onLongPress: (){}, //this will open the long press menu
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Responsiveness.setHeight(context, 50),
                  width: Responsiveness.setWidth(context, 50),
                  child: Image.network(
                    "https://spoonacular.com/cdn/ingredients_100x100/" + ingredient.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: Responsiveness.setWidth(context, 10.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        capitalizeFirstLetter(ingredient.originalName != null ? ingredient.originalName : ingredient.name),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: Responsiveness.setHeight(context, 5.0),
                      ),
                      Text(
                        capitalizeFirstLetter(ingredient.name),
                        style: TextStyle(
                          fontSize: 14,
                          color: Gray,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Responsiveness.setWidth(context, 10.0)),
                Text(
                  amt,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class GroceryListItem extends StatelessWidget {
  final IngredientItem ingredient;

  GroceryListItem(this.ingredient,);

  @override
  Widget build(BuildContext context) {
    String amt = ingredient.measures.us.amount.toString() + " " + ingredient.measures.us.unitShort;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: (){},
        onLongPress: (){},
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Responsiveness.setHeight(context, 50),
                  width: Responsiveness.setWidth(context, 50),
                  child: Image.network(
                    "https://spoonacular.com/cdn/ingredients_100x100/" + ingredient.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: Responsiveness.setWidth(context, 10.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        capitalizeFirstLetter(ingredient.originalName != null ? ingredient.originalName : ingredient.name),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: Responsiveness.setHeight(context, 5.0),
                      ),
                      Text(
                        capitalizeFirstLetter(ingredient.name),
                        style: TextStyle(
                          fontSize: 14,
                          color: Gray,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Responsiveness.setWidth(context, 10.0)),
                Text(
                  amt,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class PantryListItem extends StatelessWidget {
  final IngredientItem ingredient;

  PantryListItem(this.ingredient,);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: GestureDetector(
        onTap: (){},
        onLongPress: () {},
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Responsiveness.setHeight(context, 50),
                  width: Responsiveness.setWidth(context, 50),
                  child: Image.network(
                    ingredient.grocery != null
                        ? ingredient.grocery[0].images[0]
                        : "https://spoonacular.com/cdn/ingredients_100x100/" +
                        ingredient.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: Responsiveness.setWidth(context, 10.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ingredient.grocery != null ? ingredient.grocery[0]
                            .productName : capitalizeFirstLetter(
                            ingredient.name),
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                      ),
                      SizedBox(
                        height: Responsiveness.setHeight(context, 5.0),
                      ),
                      Text(
                        capitalizeFirstLetter(ingredient.name),
                        style: TextStyle(
                          fontSize: 14,
                          color: Gray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}