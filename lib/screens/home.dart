import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/widget/home.dart';
import 'package:whats4dinner/models/state.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/screens/login.dart';
import 'package:whats4dinner/screens/loading.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/functions/home.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  StateModel appState;
  Recipe nextMeal;
  List<String> userFavorites;

  Widget _buildContent() {
    if (appState.isLoading) {
      return new LoadingScreen();
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return Scaffold(
        body: RecipeCard(
          isFavorite: inFavorites(context, nextMeal),
          meal: nextMeal,
          handleFavorite: changeFavorite,
        ),
        bottomNavigationBar: BottomMenuBar(selectedIndex: 0,),
      );
    }
  }

  void changeFavorite(){
    setState(() {
      favoritesChanged(context, nextMeal);
    });
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    if(!StateWidget.of(context).state.isLoading && StateWidget.of(context).state.schedule != null)
      nextMeal = getNextMeal(context);
    return _buildContent();
  }
}