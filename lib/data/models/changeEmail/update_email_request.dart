class UpdateEmailRequest {
  final String email;
  final String otp;

  UpdateEmailRequest(this.email, this.otp);

  Map toJson() => {
    "email": email,
    "otp": otp
  };
}