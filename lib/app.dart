import 'package:flutter/material.dart';
import 'package:whats4dinner/screens/login.dart';
import 'package:whats4dinner/screens/home.dart';
import 'package:whats4dinner/theme.dart';

class Whats4DinnerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "What's 4 Dinner",
      theme: buildTheme(),
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}