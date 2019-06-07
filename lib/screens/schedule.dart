import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/widget/favorites_schedule.dart';
import 'package:whats4dinner/functions/favorites_schedule.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/utils/store.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
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
    TabBarView _ret = new TabBarView(children: <Widget>[],);
    List<Recipe> meals = mealList(context);
    List<Recipe> sides = sideList(context);
    List<Recipe> desserts = dessertList(context);
    if(meals.length > 0) {
      _ret.children.add(
        ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, int) {
            return RecipeListItem(meals[int], _favoritesChanged, inFavorites(meals[int], context));
          },
        ),
      );
    }else{
      _ret.children.add(
        Center(
          child: Text(
            "No scheduled meals found",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      );
    }
    if(sides.length > 0) {
      _ret.children.add(
        ListView.builder(
          itemCount: sides.length,
          itemBuilder: (context, int) {
            return RecipeListItem(sides[int], _favoritesChanged, inFavorites(sides[int], context));
          },
        ),
      );
    }else{
      _ret.children.add(
        Center(
          child: Text(
            "No scheduled sides found",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      );
    }
    if(desserts.length > 0) {
      _ret.children.add(
        ListView.builder(
          itemCount: desserts.length,
          itemBuilder: (context, int) {
            return RecipeListItem(desserts[int], _favoritesChanged, inFavorites(desserts[int], context));
          },
        ),
      );
    }else{
      _ret.children.add(
        Center(
          child: Text(
            "No scheduled desserts found",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      );
    }
    return _ret;
  }
  void _favoritesChanged(Recipe r) async {
    setState(() {
      if(!inFavorites(r, context)){
        StateWidget.of(context).state.favorites.add(r);
      }else{
        StateWidget.of(context).state.favorites.removeWhere((rec) => rec.id == r.id);
      }
    });
    await updateFavoriteMeal(StateWidget.of(context).state.user.uid, r);
  }
}