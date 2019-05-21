import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Recipes',
                textAlign: TextAlign.center,
              ),
              // Space between "Recipes" and the button:
              SizedBox(height: 50.0),
              MaterialButton(
                color: Colors.white,
                child: Text("Sign In with Google"),
                onPressed: () => print("Button pressed."),
              )
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