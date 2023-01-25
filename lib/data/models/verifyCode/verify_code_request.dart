class VerifyCodeRequest {
  final String email;
  final String code;
  final int type;
  final String mobile;
  final bool isEmail;

  VerifyCodeRequest(this.email, this.code, this.type, this.mobile, this.isEmail);

  Map toJson() => {
    "email": email,
    "otp": code,
    "type": type,
    "mobile": mobile,
    "is_email": isEmail,
  };
}