import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildTheme() {
  // We're going to define all of our font styles
  // in this method:
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 40.0,
        color: DarkGray,
      ),
      subhead: base.subhead.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 30.0,
        color: DarkGray,
      ),
      title: base.title.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        color: DarkGray,
      ),
      subtitle: base.subtitle.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        color: DarkGray,
      ),
      body1: base.body1.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: DarkGray,
      ),
      body2: base.body2.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        color: OffWhite,
      ),
      caption: base.caption.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: DarkGray,
      ),
      display1: base.display1.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: OffWhite,
      ),
      display2: base.display2.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        color: OffWhite,
      ),
      display3: base.display3.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        color: OffWhite,
      ),
    );
  }

  // We want to override a default light blue theme.
  final ThemeData base = ThemeData.light();

  // And apply changes on it:
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
  );
}