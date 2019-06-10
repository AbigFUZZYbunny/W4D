import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/functions/groceries.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/utils/string_format.dart';

class GroceriesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GroceriesScreenState();
}
class GroceriesScreenState extends State<GroceriesScreen> {
  final int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text(
          "Groceries",
          style: Theme
              .of(context)
              .textTheme
              .display3,
        ),
        centerTitle: true,
      ),
      body: new DefaultTabController(
        length: 3,
        child: new Column(
          children: <Widget>[
            new Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: new Material(
                color: OffWhite,
                child: new TabBar(
                  labelColor: DarkGray,
                  unselectedLabelColor: Gray,
                  indicatorColor: SecondaryColor,
                  tabs: _buildTabs(),
                ),
              ),
            ),
            new Expanded(
              child: _buildTabViews(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenuBar(selectedIndex: _selectedIndex,),
    );
  }
  List<Tab> _buildTabs() {
    List<Tab> _tabs = new List<Tab>();
    _tabs.add(new Tab(text: "Required"));
    _tabs.add(new Tab(text: "Shopping List"));
    _tabs.add(new Tab(text: "Pantry"));
    return _tabs;
  }
  TabBarView _buildTabViews(BuildContext context) {
    TabBarView _ret = new TabBarView(children: <Widget>[],);
    List<IngredientItem> pantry = pantryList(context);
    List<IngredientItem> required = requiredList(context);
    List<IngredientItem> shopping = shoppingList(context);
    if (required.length > 0) {
      _ret.children.add(
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: LightGray,
          ),
          itemCount: required.length,
          itemBuilder: (context, int) {
            return RequiredListItem(ingredient: required[int]);
          },
        ),
      );
    } else {
      _ret.children.add(
        Center(
          child: Text(
            "No required ingredients found",
            style: Theme
                .of(context)
                .textTheme
                .subtitle,
          ),
        ),
      );
    }
    if (shopping.length > 0) {
      _ret.children.add(
            ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: LightGray,
              ),
              itemCount: shopping.length,
              itemBuilder: (context, int) {
                return GroceryListItem(shopping[int],);
              },
            ),
      );
    } else {
      _ret.children.add(
        Center(
          child: Text(
            "No groceries added yet",
            style: Theme
                .of(context)
                .textTheme
                .subtitle,
          ),
        ),
      );
    }
    if (pantry.length > 0) {
      _ret.children.add(
            ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: LightGray,
              ),
              itemCount: pantry.length,
              itemBuilder: (context, int) {
                return PantryListItem(pantry[int],);
              },
            ),
      );
    } else {
      _ret.children.add(
        Center(
          child: Text(
            "No pantry groceries found",
            style: Theme
                .of(context)
                .textTheme
                .subtitle,
          ),
        ),
      );
    }
    return _ret;
  }
  void reqAddToShoppingList(IngredientItem ing){
    setState((){

    });
  }
}

class RequiredListItem extends StatelessWidget {
  final IngredientItem ingredient;
  final bool inPantry;

  RequiredListItem({this.ingredient, this.inPantry,});

  @override
  Widget build(BuildContext context) {
    String amt = ingredient.measures.us.amount.toString() + " " + ingredient.measures.us.unitShort;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () => requiredOnTap(context, ingredient, moveToShopping, moveToPantry, changeBase),
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