class SignUpRequest{
  String fullName;
  String mobile;
  String email;
  String city;
  String zipCode;
  String password;

  SignUpRequest(this.fullName, this.mobile, this.email, this.city, this.zipCode, this.password);

  Map toJson() => {
    "fullName": fullName,
    "mobile": mobile,
    "email": email,
    "city": city,
    "zipCode": zipCode,
    "password": password,
  };
}