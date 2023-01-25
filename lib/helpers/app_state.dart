import 'package:base_flutter/data/models/verifyCode/verify_code_response.dart';
import 'package:base_flutter/helpers/mixin/auth_mixin.dart';

class AppState with AuthMixin {
  //Checks the Login/OnBoarded status of the User
  Future<List<bool>> checkForLoginCredentials() async {
    bool onBoarded = true;
    var isLoggedIn = false;

    return [onBoarded, isLoggedIn];
  }
}
