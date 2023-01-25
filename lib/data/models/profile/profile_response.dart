import 'package:base_flutter/data/models/verifyCode/verify_code_response.dart';

class ProfileResponse {
  Profile? profile;

  ProfileResponse({this.profile});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}