import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/utils/store.dart';
import 'package:whats4dinner/utils/favorites.dart';
import 'package:whats4dinner/widget/recipe_card.dart';
import 'package:whats4dinner/models/state.dart';
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/screens/login.dart';

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
      return Scaffold(
        body: _buildLoadingIndicator(),
      );
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return Scaffold(
        //This is where the home screen is actually built
        body: RecipeCard(
          recipe: nextMeal,
          handleFavorite: _favoritesChanged,
        ),
      );
    }
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "What's 4 Dinner",
            style: Theme.of(context).textTheme.headline,
          ),
          SizedBox(height: 100),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  // Inactive widgets are going to call this method to
  // signalize the parent widget HomeScreen to refresh the list view:
  void _favoritesChanged() {
    setState(() {
      FavoritesFunctions.addRemoveFavorite(nextMeal, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    appState = StateWidget.of(context).state;
    nextMeal = StateWidget.of(context).state.userInfo.schedule.meal[0];
    return _buildContent();
  }
}