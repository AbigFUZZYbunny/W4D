import 'package:flutter/material.dart';
import 'package:whats4dinner/utils/responsive.dart';

ThemeData buildTheme() {
  // We're going to define all of our font styles
  // in this method:
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w500,
        fontSize: 40.0,
        color: const Color(0xFF807a6b),
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