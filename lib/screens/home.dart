import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/utils/store.dart';
import 'package:whats4dinner/widget/recipe_card.dart';
import 'package:whats4dinner/models/state.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/screens/login.dart';
import 'package:whats4dinner/screens/loading.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';
import 'package:whats4dinner/utils/spoonacular.dart';

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
          meal: nextMeal,
          handleFavorite: _favoritesChanged,
        ),
        bottomNavigationBar: BottomMenuBar(selectedIndex: 0,),
      );
    }
  }

  // Inactive widgets are going to call this method to
  // signalize the parent widget HomeScreen to refresh the list view:
  void _favoritesChanged() async {
    await updateFavoriteMeal(StateWidget.of(context).state.user.uid, nextMeal);
    setState(() {
      if(!inFavorites()){
        StateWidget.of(context).state.favorites.add(nextMeal);
      }else{
        StateWidget.of(context).state.favorites.removeWhere((rec) => rec.id == nextMeal.id);
      }
    });
  }

  bool inFavorites (){
    if(StateWidget.of(context).state.favorites != null) {
      for (var r in StateWidget
          .of(context)
          .state
          .favorites) {
        if (r.id == nextMeal.id)
          return true;
      }
    }
    return false;
  }

  Recipe getNextMeal(){
    if(StateWidget.of(context).state.schedule != null && StateWidget.of(context).state.schedule.length > 0) {
      for (var r in StateWidget
          .of(context)
          .state
          .schedule) {
        if (r.recipeType == "meal") {
          return r;
        }
      }
    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    if(!StateWidget.of(context).state.isLoading && StateWidget.of(context).state.schedule != null)
      nextMeal = getNextMeal();
    return _buildContent();
  }
}