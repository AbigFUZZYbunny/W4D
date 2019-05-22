import 'package:flutter/material.dart';

import 'package:whats4dinner/app.dart';
import 'package:whats4dinner/widget/state_widget.dart';

// - StateWidget incl. state data
//    - RecipesApp
//        - All other widgets which are able to access the data
void main() => runApp(new StateWidget(
  child: new Whats4DinnerApp(),
));