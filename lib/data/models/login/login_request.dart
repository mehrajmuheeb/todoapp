class LoginRequest {
  String email;
  String password;
  String deviceType;
  String deviceToken;

  LoginRequest(this.email, this.password, this.deviceType, this.deviceToken);

  Map toJson() => {
    "email": email,
    "password": password,
    "device_type": deviceType,
    "fcm_token": deviceToken,
  };
}