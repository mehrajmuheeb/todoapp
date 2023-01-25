import 'package:base_flutter/data/models/changeEmail/change_email_request.dart';
import 'package:base_flutter/data/models/changeEmail/update_email_request.dart';
import 'package:base_flutter/data/models/changePassword/change_passsword_request.dart';
import 'package:base_flutter/data/models/changePhone/change_phone_request.dart';
import 'package:base_flutter/data/models/changePhone/update_phone_request.dart';
import 'package:base_flutter/data/models/city/city.dart';
import 'package:base_flutter/data/models/forgotPassword/forgot_password_request.dart';
import 'package:base_flutter/data/models/forgotPassword/forgot_password_response.dart';
import 'package:base_flutter/data/models/login/login_request.dart';
import 'package:base_flutter/data/models/movies/MoviesMain.dart';
import 'package:base_flutter/data/models/notifications/delete_notification_request.dart';
import 'package:base_flutter/data/models/notifications/notifications_response.dart';
import 'package:base_flutter/data/models/notifications/toggle_notification_request.dart';
import 'package:base_flutter/data/models/profile/profile_response.dart';
import 'package:base_flutter/data/models/profile/update_profile_request.dart';
import 'package:base_flutter/data/models/resetPassword/reset_password_request.dart';
import 'package:base_flutter/data/models/signUp/sign_up_request.dart';
import 'package:base_flutter/data/models/signUp/sign_up_response.dart';
import 'package:base_flutter/data/models/state/fetched_state.dart';
import 'package:base_flutter/data/models/verifyCode/resend_code_request.dart';
import 'package:base_flutter/data/models/verifyCode/verify_code_request.dart';
import 'package:base_flutter/data/models/verifyCode/verify_code_response.dart';

abstract class WebApi {
  //Get City
  Future<List<City>> getCities(Map<String, String> query);

  //Get States
  Future<List<FetchedState>> getStates();

  //Sign Up
  Future<String> signUp(SignUpRequest request);

  //Verify Code
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request);

  //Verify Forgot Password Code
  Future<String> verifyForgotPasswordCode(VerifyCodeRequest request);

  //Login
  Future<VerifyCodeResponse> login(LoginRequest request);

  //Forgot Password
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request);

  //Reset Password
  Future<String> resetPassword(ResetPasswordRequest request);

  //Change Password
  Future<String> changePassword(ChangePasswordRequest request);

  //Get Profile
  Future<ProfileResponse> getProfile();

  //Logout
  Future<String> logout();

  //Change Email
  Future<String> changeEmail(ChangeEmailRequest request);

  //Update Email
  Future<String> updateEmail(UpdateEmailRequest request);

  //Update Profile
  Future<String> updateProfile(UpdateProfileRequest request);

  //Notifications
  Future<NotificationResponse?> getNotifications();

  //Toggle Notification
  Future<String> toggleNotification(ToggleNotificationRequest request);

  //Delete Notification
  Future<String> deleteNotification(String id);

  //Resend Code
  Future<String> resendVerificationCode(ResendCodeRequest request);

  //Change Phone
  Future<String> changePhoneNumber(ChangePhoneRequest request);

  //Update Phone
  Future<String> updatePhoneNumber(UpdatePhoneRequest request);
}
