import 'dart:developer';
import 'dart:io';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/data/models/user/user_request.dart';
import 'package:base_flutter/data/network/api_response.dart';
import 'package:base_flutter/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  bool isLoggingIn = false;
  SignedUser? user;

  /// 1. Logs in User via Gmail
  Future<void> signInWithGoogle() async {
    _setLoggingIn(true);
    webApi
        .login()
        .then((value) => onLoginSuccess(value))
        .onError((error, stackTrace) => onLoginError(error.toString()));
  }

  onLoginSuccess(SignedUser user) {
    final signedUser = user;
    this.user = user;
    saveProfile(user);

    //If successful, we check if the User if already created in FireStore
    checkUserExists(signedUser);
  }

  onLoginError(String message) {
    _setLoggingIn(false);
    getNavigator().onError(message);
  }

  void _setLoggingIn(bool isLogging) {
    isLoggingIn = isLogging;
    notifyListeners();
  }

  /// 2. Checks if the User is already created in FireStore.
  void checkUserExists(SignedUser user) {
    webApi
        .userExists(user.email!)
        .then((value) => onCheckSuccess(value))
        .onError((error, stackTrace) => onCheckError(error.toString()));
  }

  // If the user exists then we save the User and navigate to Dashboard
  onCheckSuccess(SignedUser user) {
    _setLoggingIn(false);
    saveProfile(user);
    getNavigator().onSignInSuccess();
  }

  onCheckError(String message) {
    if (user == null) {
      _setLoggingIn(false);
      getNavigator().onError(message);
      return;
    }

    createUser(user!);
  }

  //Creates User if it doesn't exist in Database
  void createUser(SignedUser user) {
    webApi
        .createUser(UserRequest(
            user.id ?? "", user.name ?? "", user.email ?? "", user.image ?? ""))
        .then((value) => onUserSuccess(value))
        .onError((error, stackTrace) => onUserError(error.toString()));
  }

  onUserSuccess(String id) async {
    final user = await getProfile();
    _setLoggingIn(false);
    getNavigator().onSignInSuccess();
  }

  onUserError(String message) {
    _setLoggingIn(false);
    getNavigator().onError(message);
  }
}
