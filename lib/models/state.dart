import 'user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StateModel{
  bool isLoading;
  User userInfo;
  FirebaseUser user;

  StateModel({
    this.isLoading = false,
    this.user,
    this.userInfo,
  });
}