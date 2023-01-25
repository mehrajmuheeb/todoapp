class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest(this.oldPassword, this.newPassword);

  Map toJson() => {
    "password": oldPassword,
    "newPassword": newPassword,
  };
}