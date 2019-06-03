import 'package:whats4dinner/colors.dart';
import 'package:flutter/material.dart';

class DynamicAppBar extends StatelessWidget {
  final double height;

  const DynamicAppBar({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            color: PrimaryColor,
          ),
          height: height,
        ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ],
    );
  }
}