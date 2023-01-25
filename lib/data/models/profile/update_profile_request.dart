import 'package:base_flutter/constants/strings.dart';

class UpdateProfileRequest {
  String fullName;
  String mobile;
  String email;
  String cityId;
  String zipCode;

  UpdateProfileRequest(this.fullName, this.mobile, this.email, this.cityId, this.zipCode);


  Map toJson() => {
    "fullName": fullName,
    "mobile": mobile,
    "email": email,
    "city": cityId,
    "zipCode": zipCode
  };
}