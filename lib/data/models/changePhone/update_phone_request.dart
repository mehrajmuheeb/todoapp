class UpdatePhoneRequest {
  String mobile;
  String code;

  UpdatePhoneRequest(this.mobile, this.code);

  Map toJson() => {
    "mobile": mobile,
    "otp": code
  };
}