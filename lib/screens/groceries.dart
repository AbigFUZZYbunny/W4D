import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/widget/list_item.dart';

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
            return IngredientListItem(required[int], (){}, true,);
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
        ListView.builder(
          itemCount: shopping.length,
          itemBuilder: (context, int) {
            return IngredientListItem(shopping[int], (){}, true,);
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
        ListView.builder(
          itemCount: pantry.length,
          itemBuilder: (context, int) {
            return IngredientListItem(pantry[int], (){}, true,);
          },
        ),
      );
    } else {
      _ret.children.add(
        Center(
          child: Text(
            "No pantry items found",
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
  List<IngredientItem> shoppingList(BuildContext context) {
    List<IngredientItem> _ret = new List<IngredientItem>();
    for (var r in StateWidget
        .of(context)
        .state
        .shopping) {
      _ret.add(r);
    }
    return _ret;
  }

  List<IngredientItem> pantryList(BuildContext context) {
    List<IngredientItem> _ret = new List<IngredientItem>();
    for (var r in StateWidget
        .of(context)
        .state
        .pantry) {
      _ret.add(r);
    }
    return _ret;
  }
  List<IngredientItem> requiredList(BuildContext context) {
    List<IngredientItem> _ret = new List<IngredientItem>();
    for (var r in StateWidget
        .of(context)
        .state
        .schedule) {
      for (var i in r.extendedIngredients) {
        print("Start");
        IngredientItem _ing;
        if(_ret != null && _ret.length > 0) {
          print(0);
          //_ing = _ret.firstWhere((_i) => _i.id == i.id);
        }
        if (_ing != null) {
          print(1);
          _ing.measures.us.amount += i.measures.us.amount;
          _ret.removeWhere((_i) => _i.id == i.id);
        } else {
          print(2);
          _ing = i;
        }
        for (var _i in StateWidget
            .of(context)
            .state
            .pantry) {
          print(3);
          if (_i.measures.us.amount != null && _i.id == _ing.id) {
            print(4);
            _ing.measures.us.amount -= _i.measures.us.amount;
            if(_ing.measures.us.amount <= 0){
              print(5);
              _ing = null;
            }
          }
        }
        if(_ing != null)
          print("end");
          _ret.add(_ing);
      }
    }
    return _ret;
  }
  Future<void> _favoritesChanged(IngredientItem r) async {
    for(var _i in StateWidget.of(context).state.preferences.ingredients.favorites) {
      if (_i == r.name) {
        setState(() {
          StateWidget
              .of(context)
              .state
              .preferences
              .ingredients
              .favorites
              .removeWhere((i) => i == r.name);
        });
        return false;
      }
      setState(() {
        StateWidget.of(context).state.preferences.ingredients.favorites.add(r.name);
      });
    }
    setState(() {
      StateWidget.of(context).state.preferences.ingredients.favorites.add(r.name);
    });
    //await updateFavoriteMeal(StateWidget.of(context).state.user.uid, r);
    return true;
  }
}