import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/widget/groceries.dart';
import 'package:whats4dinner/functions/groceries.dart';
import 'package:whats4dinner/models/ingredient_item.dart';

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
            return RequiredListItem(required[int], true,);
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
                return GroceryListItem(shopping[int], true,);
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
                return PantryListItem(pantry[int], true,);
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
}