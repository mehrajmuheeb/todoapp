class VerifyCodeResponse {
  Profile? profile;
  Token? token;

  VerifyCodeResponse({this.profile, this.token});

  VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Profile {
  int? userId;
  String? shortName;
  String? firstName;
  String? lastName;
  String? email;
  int? emailVerified;
  String? mobile;
  int? mobileVerified;
  String? city;
  String? state;
  String? zipcode;
  String? profileImage;
  String? userImage;
  int? isNotificationEnabled;
  String? status;

  Profile(
      {this.userId,
        this.shortName,
        this.firstName,
        this.lastName,
        this.email,
        this.emailVerified,
        this.mobile,
        this.mobileVerified,
        this.city,
        this.state,
        this.zipcode,
        this.profileImage,
        this.userImage,
        this.isNotificationEnabled,
        this.status});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    shortName = json['short_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerified = json['email_verified'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    profileImage = json['profile_image'];
    userImage = json['userImage'];
    isNotificationEnabled = json['is_notification_enabled'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['short_name'] = shortName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['mobile'] = mobile;
    data['mobile_verified'] = mobileVerified;
    data['city'] = city;
    data['state'] = state;
    data['zipcode'] = zipcode;
    data['profile_image'] = profileImage;
    data['userImage'] = userImage;
    data['is_notification_enabled'] = isNotificationEnabled;
    data['status'] = status;
    return data;
  }
}

class Token {
  String? tokenType;
  String? accessToken;

  Token({this.tokenType, this.accessToken});

  Token.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_type'] = tokenType;
    data['access_token'] = accessToken;
    return data;
  }
}