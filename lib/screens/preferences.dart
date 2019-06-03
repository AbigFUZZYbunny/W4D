import 'package:flutter/material.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/widget/bottom_menu.dart';

class PreferencesScreen extends StatelessWidget {
  final int _selectedIndex = 4;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
          title: Text(
            "Preferences",
            style: Theme.of(context).textTheme.display3,
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomMenuBar(selectedIndex: _selectedIndex,),
      ),
    );
  }
}