import 'package:whats4dinner/colors.dart';
import 'package:flutter/material.dart';

class BottomMenuBar extends StatelessWidget {
  final int selectedIndex;

  const BottomMenuBar({Key key, this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: DarkGray,
          ),
          title: Text(
            'Home',
            style: new TextStyle(color: DarkGray),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: DarkGray,
            ),
            title: Text(
              'Schedule',
              style: new TextStyle(color: DarkGray),
            )
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: DarkGray,
            ),
            title: Text(
              'Favorites',
              style: new TextStyle(color: DarkGray),
            )
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.local_grocery_store,
              color: DarkGray,
            ),
            title: Text(
              'Groceries',
              style: new TextStyle(color: DarkGray),
            )
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: DarkGray,
            ),
            title: Text(
              'Preferences',
              style: new TextStyle(color: DarkGray),
            )
        ),
      ],
      currentIndex: selectedIndex,
      onTap: (int index) {
        print("Pressed" + index.toString());

        switch(index) {
          case 0:
            if(selectedIndex != 0)
              Navigator.of(context).pop();
            break;
          case 1:
            if(selectedIndex != 0)
              Navigator.of(context).popAndPushNamed('/schedule');
            else
              Navigator.of(context).pushNamed('/schedule');
            break;
          case 2:
            if(selectedIndex != 0)
              Navigator.of(context).popAndPushNamed('/favorites');
            else
              Navigator.of(context).pushNamed('/favorites');
            break;
          case 3:
            if(selectedIndex != 0)
              Navigator.of(context).popAndPushNamed('/groceries');
            else
              Navigator.of(context).pushNamed('/groceries');
            break;
          case 4:
            if(selectedIndex != 0)
              Navigator.of(context).popAndPushNamed('/preferences');
            else
              Navigator.of(context).pushNamed('/preferences');
            break;
        }
      },
    );
  }
}