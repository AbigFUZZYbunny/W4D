import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/utils/store.dart';
import 'package:whats4dinner/widget/recipe_card.dart';
import 'package:whats4dinner/models/state.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/screens/login.dart';
import 'package:whats4dinner/screens/loading.dart';

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
        //This is where the home screen is actually built
        body: RecipeCard(
          isFavorite: inFavorites(),
          recipe: nextMeal,
          handleFavorite: _favoritesChanged,
        ),
      );
    }
  }

  // Inactive widgets are going to call this method to
  // signalize the parent widget HomeScreen to refresh the list view:
  void _favoritesChanged() async {
    await updateFavoriteMeal(StateWidget.of(context).state.user.uid, nextMeal);
    setState(() {
      if(!inFavorites()){
        StateWidget.of(context).state.userInfo.favorites.add(nextMeal);
      }else{
        StateWidget.of(context).state.userInfo.favorites.removeWhere((rec) => rec.id == nextMeal.id);
      }
    });
  }

  bool inFavorites (){
    for (var r in StateWidget.of(context).state.userInfo.favorites) {
      if (r.id == nextMeal.id)
        return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    if(!StateWidget.of(context).state.isLoading)
      nextMeal = StateWidget.of(context).state.userInfo.schedule.firstWhere((r) => r.recipeType == "Meal");
    return _buildContent();
  }
}