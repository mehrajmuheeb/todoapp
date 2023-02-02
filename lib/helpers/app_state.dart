import 'package:base_flutter/helpers/mixin/auth_mixin.dart';

class AppState with AuthMixin {
  //Checks the Login/OnBoarded status of the User
  Future<List<bool>> checkForLoginCredentials() async {
    bool onBoarded = true;
    var profile = await getProfile();

    bool isLoggedIn = profile != null;

    return [onBoarded, isLoggedIn];
  }
}
