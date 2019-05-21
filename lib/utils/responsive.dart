import 'package:flutter/material.dart';

class Responsiveness{
  static double setWidth(var context, double _in){
    return (_in * (MediaQuery.of(context).size.width / 480));
  }

  static double setHeight(var context, double _in){
    return (_in * (MediaQuery.of(context).size.height / 800));
  }
}