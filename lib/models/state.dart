import 'user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StateModel{
  bool isLoading;
  User userInfo;
  FirebaseUser user;
  String loadingStatus;

  StateModel({
    this.isLoading = false,
    this.user,
    this.userInfo,
    this.loadingStatus = "",
  });
}