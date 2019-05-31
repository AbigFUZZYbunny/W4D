import 'package:flutter/material.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/widget/state_widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "What's 4 Dinner",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
              // Space between "Recipes" and the button:
              SizedBox(height: Responsiveness.setHeight(context, 100.0)),
              CircularProgressIndicator(),
              Positioned(
                bottom: 20.0,
                child: Text(
                  StateWidget.of(context).state.loadingStatus,
                  style: TextStyle(
                    fontSize: Responsiveness.setHeight(context, 14.0),
                    color: Colors.white,
                    fontFamily: "Rubik",
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("res/img/login_bg/veggie-campfire-frittata-9.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}