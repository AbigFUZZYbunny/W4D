import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whats4dinner/models/state.dart';
import 'package:whats4dinner/models/user.dart';
import 'package:whats4dinner/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    googleAccount = await getSignedInAccount(googleSignIn);

    if (googleAccount == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      await signInWithGoogle();
    }
  }

  Future<User> getUser() async {
    DocumentSnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .document(state.user.uid)
        .get();
    if (querySnapshot.exists) {
      /*CollectionReference _fav = await Firestore.instance
          .collection('users')
          .document(state.user.uid)
          .collection('favorites');
      CollectionReference _sch = await Firestore.instance
          .collection('users')
          .document(state.user.uid)
          .collection('schedule');
      CollectionReference _pref = await Firestore.instance
          .collection('users')
          .document(state.user.uid)
          .collection('preferences');
      CollectionReference _groc = await Firestore.instance
          .collection('users')
          .document(state.user.uid)
          .collection('groceries');
      QuerySnapshot _sub = await Firestore.instance
          .collection('users')
          .document(state.user.uid)
          .collection('subscription').getDocuments();
      _sub.documents.forEach((ds) => (){
         SubscriptionRecord.fromMap(ds.data);
      });*/
      return User.fromMap(querySnapshot.data);
    }
    return User.newUser();
  }

  Future<Null> signInWithGoogle() async {
    if (googleAccount == null) {
      // Start the sign-in process:
      googleAccount = await googleSignIn.signIn();
    }
    FirebaseUser firebaseUser = await signIntoFirebase(googleAccount);
    User user = await getUser();
    setState(() {
      state.isLoading = false;
      state.user = firebaseUser;
      state.userInfo = user;
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