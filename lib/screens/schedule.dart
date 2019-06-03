import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/widget/list_item.dart';

class ScheduleScreen extends StatelessWidget {
  final int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
          title: Text(
            "Schedule",
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
    _tabs.add(new Tab(text: "Meals"));
    _tabs.add(new Tab(text: "Sides"));
    _tabs.add(new Tab(text: "Desserts"));
    return _tabs;
  }
  TabBarView _buildTabViews(BuildContext context){
    List<Recipe> meals = mealList(context);
    TabBarView _ret = new TabBarView(children: <Widget>[],);
    _ret.children.add(
        ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, int) {
            return RecipeListItem(meals[int], null, true);
          },
        ),
    );
    _ret.children.add(new Text("Sides"));
    _ret.children.add(new Text("Desserts"));
    return _ret;
  }
  List<Recipe> mealList(BuildContext context){
    List<Recipe> _ret = new List<Recipe>();
    for(var r in StateWidget.of(context).state.schedule){
      if(r.recipeType == "meal"){
        _ret.add(r);
      }
    }
    return _ret;
  }
  List<Recipe> sideList(BuildContext context){
    List<Recipe> _ret = new List<Recipe>();
    for(var r in StateWidget.of(context).state.schedule){
      if(r.recipeType == "side"){
        _ret.add(r);
      }
    }
    return _ret;
  }
  List<Recipe> dessertList(BuildContext context){
    List<Recipe> _ret = new List<Recipe>();
    for(var r in StateWidget.of(context).state.schedule){
      if(r.recipeType == "dessert"){
        _ret.add(r);
      }
    }
    return _ret;
  }
}