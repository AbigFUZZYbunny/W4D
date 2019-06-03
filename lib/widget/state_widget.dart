import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whats4dinner/models/state.dart';
import 'package:whats4dinner/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whats4dinner/utils/store.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/models/preferences.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/models/subscription_record.dart';
import 'package:whats4dinner/utils/spoonacular.dart';

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidget({
    @required this.child,
    this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget)
    as _StateDataWidget)
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  StateModel state;
  GoogleSignInAccount googleAccount;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  Future<Null> initUser() async {
    setState(() {
      state.loadingStatus = "Initializing User Profile";
    });
    googleAccount = await getSignedInAccount(googleSignIn);
    if (googleAccount == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      await signInWithGoogle();
    }
  }

  Future<Null> signInWithGoogle() async {
    setState(() {
      state.loadingStatus = "Signing in with Google";
    });
    if (googleAccount == null) {
      // Start the sign-in process:
      googleAccount = await googleSignIn.signIn();
    }
    FirebaseUser firebaseUser = await signIntoFirebase(googleAccount);
    setState(() {
      state.loadingStatus = "Retrieving Scheduled Recipes";
    });
    List<Recipe> sch = await getRecipes(
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .collection('schedule')
    );
    setState(() {
      state.loadingStatus = "Retrieving Favorite Recipes";
    });
    List<Recipe> fav = await getRecipes(
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .collection('favorites')
    );
    List<SubscriptionRecord> sub = await getSubscription(firebaseUser.uid);
    setState(() {
      state.loadingStatus = "Retrieving Pantry Items";
    });
    List<IngredientItem> pant = await getIngredientsList(
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .collection('pantry')
    );
    setState(() {
      state.loadingStatus = "Retrieving Grocery List";
    });
    List<IngredientItem> shop = await getIngredientsList(
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .collection('shopping')
    );
    setState(() {
      state.loadingStatus = "Retrieving User Preferences";
    });
    Preferences pref = await getPreferences(firebaseUser.uid);
    if(sch == null || sch.length == 0){
      sch = [await getRandomRecipe(pref)];
    }
    setState(() {
      state.schedule = sch;
      state.favorites = fav;
      state.preferences = pref;
      state.shopping = shop;
      state.pantry = pant;
      state.subscription = sub;
      state.isLoading = false;
      state.loadingStatus = "";
      state.user = firebaseUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}