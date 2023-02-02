import 'package:base_flutter/base/base_navigator.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginNavigator extends BaseNavigator {
  void onSignInSuccess();
}
