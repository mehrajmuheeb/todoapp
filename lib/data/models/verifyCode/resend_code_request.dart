class ResendCodeRequest {
  String email;
  String mobile;
  bool isEmail;

  ResendCodeRequest(this.email, this.mobile, this.isEmail);

  Map toJson() => {
    "email": email,
    "mobile": mobile,
    "is_email": isEmail
  };
}