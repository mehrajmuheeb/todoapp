class ChangePhoneRequest {
  String mobile;

  ChangePhoneRequest(this.mobile);

  Map toJson() => {
    "mobile": mobile
  };
}