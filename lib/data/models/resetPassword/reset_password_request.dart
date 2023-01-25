class ResetPasswordRequest {
  String token;
  String password;
  String confirmPassword;

  ResetPasswordRequest(this.token, this.password, this.confirmPassword);

  Map toJson() => {
    "token": token,
    "newPassword": password,
    "newPasswordConfirmation": confirmPassword,
  };
}