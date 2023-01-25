class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);

  Map toJson() => {
    "email": email,
  };
}