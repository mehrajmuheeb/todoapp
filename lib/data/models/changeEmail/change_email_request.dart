class ChangeEmailRequest {
  String email;

  ChangeEmailRequest(this.email);

  Map toJson() => {"email": email};
}
