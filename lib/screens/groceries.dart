import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/widget/list_item.dart';
import 'package:whats4dinner/utils/store.dart';

class GroceriesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GroceriesScreenState();
}

class GroceriesScreenState extends State<GroceriesScreen> {
  final int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
          title: Text(
            "Groceries",
            style: Theme.of(context).textTheme.display3,
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
  List<Tab> _buildTabs(){
    List<Tab> _tabs = new List<Tab>();
    _tabs.add(new Tab(text: "Required"));
    _tabs.add(new Tab(text: "Shopping List"));
    _tabs.add(new Tab(text: "Pantry"));
    return _tabs;
  }
  TabBarView _buildTabViews(BuildContext context){
    TabBarView _ret = new TabBarView(children: <Widget>[],);
    List<IngredientItem> pantry = pantryList(context);
    List<IngredientItem> required = requiredList(context);
    if(required.length > 0) {
      _ret.children.add(
        ListView.builder(
          itemCount: required.length,
          itemBuilder: (context, int) {
            return IngredientListItem(required[int], _favoritesChanged, true,);
          },
        ),
      );
    }else{
      _ret.children.add(
        Center(
          child: Text(
            "No required ingredients found",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      );
    }
    if(pantry.length > 0) {
      _ret.children.add(
        ListView.builder(
          itemCount: pantry.length,
          itemBuilder: (context, int) {
            return IngredientListItem(pantry[int], _favoritesChanged, true,);
          },
        ),
      );
    }else{
      _ret.children.add(
        Center(
          child: Text(
            "No pantry items found",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      );
    }
    return _ret;
  }
  List<IngredientItem> pantryList(BuildContext context){
    List<IngredientItem> _ret = new List<IngredientItem>();
    for(var r in StateWidget.of(context).state.pantry){
      _ret.add(r);
    }
    return _ret;
  }
  List<IngredientItem> requiredList(BuildContext context){
    List<IngredientItem> _ret = new List<IngredientItem>();
    for(var r in StateWidget.of(context).state.schedule){
      for(var i in r.extendedIngredients){
        IngredientItem _ing = _ret.firstWhere((_i) => _i.id == i.id);
        if(_ing != null){
          _ing.amount += i.amount;
          _ret.removeWhere((_i) => _i.id == i.id);
        }else {
          _ing = i;
        }
        for(var _i in StateWidget.of(context).state.pantry){
          if(_i.amount != null){
            _ing.amount -= _i.amount;
            if(_ing.amount < 0){
              _ing.amount = 0;
            }
          }
        }
        _ret.add(_ing);
      }
    }
    return _ret;
  }
  void _favoritesChanged(IngredientItem r) async {
    setState(() {
      //StateWidget.of(context).state.favorites.removeWhere((rec) => rec.id == r.id);
    });
    //await updateFavoriteMeal(StateWidget.of(context).state.user.uid, r);
  }
}