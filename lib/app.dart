import 'package:flutter/material.dart';
import 'package:whats4dinner/screens/login.dart';
import 'package:whats4dinner/screens/home.dart';
import 'package:whats4dinner/screens/meal_details.dart';
import 'package:whats4dinner/screens/schedule.dart';
import 'package:whats4dinner/screens/preferences.dart';
import 'package:whats4dinner/screens/favorites.dart';
import 'package:whats4dinner/screens/groceries.dart';
import 'package:whats4dinner/theme.dart';

class Whats4DinnerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "What's 4 Dinner",
      theme: buildTheme(),
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/mealdetail': (context) => MealDetailsScreen(),
        '/schedule': (context) => ScheduleScreen(),
        '/preferences': (context) => PreferencesScreen(),
        '/favorites': (context) => FavoriteScreen(),
        '/groceries': (context) => GroceriesScreen(),
      },
    );
  }
}