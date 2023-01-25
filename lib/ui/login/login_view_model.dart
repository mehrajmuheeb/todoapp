import 'dart:developer';
import 'dart:io';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/login/login_request.dart';
import 'package:base_flutter/data/models/verifyCode/verify_code_response.dart';
import 'package:base_flutter/data/network/api_response.dart';
import 'package:base_flutter/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {

  bool isLoggingIn = false;

  ApiResponse<VerifyCodeResponse> loginResponse = ApiResponse.stopped();

  Future<void> initData() async {

  }

  // void login() {
  //   // _setLoginResponse(ApiResponse.loading());
  //
  //   FirebaseAuth.instance.authStateChanges().listen((user) {
  //     if(user != null) {
  //       getNavigator().onError("Firebase Logger");
  //     }
  //   });
  // }

  Future<void> signInWithGoogle() async {
    _setLoggingIn(true);
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    _setLoggingIn(false);
    if(user.user != null) {
      getNavigator().onError("Logged In");
    }
  }

  void _setLoggingIn(bool isLogging) {
    isLoggingIn = isLogging;
    notifyListeners();
  }

}
