import 'dart:developer';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/ui/profile/profile_navigator.dart';

class ProfileViewModel extends BaseViewModel<ProfileNavigator> {

  SignedUser? user;
  String image = "";

  Future<void> setInitialData() async {
    user = await getProfile();
    image = user?.image ?? "";
    notifyListeners();
  }
}
