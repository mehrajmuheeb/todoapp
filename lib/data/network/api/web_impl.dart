import 'dart:convert';
import 'dart:developer';
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
import 'package:base_flutter/data/network/api/web.dart';
import 'package:base_flutter/data/network/api_end_points.dart';
import 'package:base_flutter/data/network/api_response.dart';
import 'package:base_flutter/data/network/services/base_api_service.dart';
import 'package:base_flutter/data/network/services/network_api_service.dart';

class WebApiImpl implements WebApi {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<List<City>> getCities(Map<String, String> query) async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints.city, queryString: query);
      var cityList = <City>[];
      final jsonData = ((response as ApiResponse).data as List);
      for (var element in jsonData) {
        cityList.add(City.fromJson(element));
      }
      return cityList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FetchedState>> getStates() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints.state);
      var stateList = <FetchedState>[];
      final jsonData = ((response as ApiResponse).data as List);
      for (var element in jsonData) {
        stateList.add(FetchedState.fromJson(element));
      }
      return stateList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signUp(SignUpRequest request) async {
    try {
      dynamic response = await _apiService.sendRequest<SignUpRequest>(
          ApiEndPoints.signUp, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request) async {
    try {
      dynamic response =
          await _apiService.sendRequest(ApiEndPoints.verifyEmailPhone, request);
      final jsonData =
          VerifyCodeResponse.fromJson((response as ApiResponse).data);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyCodeResponse> login(LoginRequest request) async {
    try {
      dynamic response =
          await _apiService.sendRequest(ApiEndPoints.login, request);
      final jsonData =
          VerifyCodeResponse.fromJson((response as ApiResponse).data);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) async {
    try {
      dynamic response =
          await _apiService.sendRequest(ApiEndPoints.forgotPassword, request);
      final jsonData = ForgotPasswordResponse.fromJson((response as ApiResponse).data);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> verifyForgotPasswordCode(VerifyCodeRequest request) async {
    try {
      dynamic response =
          await _apiService.sendRequest(ApiEndPoints.verifyEmailPhone, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> resetPassword(ResetPasswordRequest request) async {
    try {
      dynamic response =
      await _apiService.sendRequest(ApiEndPoints.resetPassword, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> changePassword(ChangePasswordRequest request) async {
    try {
      dynamic response =
          await _apiService.sendRequest(ApiEndPoints.changePassword, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileResponse> getProfile() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints.profile);
      final jsonData = ProfileResponse.fromJson((response as ApiResponse).data);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> logout() async {
    try {
      dynamic response = await _apiService.sendRequest(ApiEndPoints.logout, null);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> changeEmail(ChangeEmailRequest request) async {
    try {
      dynamic response = await _apiService.sendRequest(ApiEndPoints.changeEmail, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateEmail(UpdateEmailRequest request) async {
    try {
      dynamic response = await _apiService.sendRequest(ApiEndPoints.updateEmail, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateProfile(UpdateProfileRequest request) async {
    try {
      dynamic response = await _apiService.updateRequest(ApiEndPoints.updateProfile, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationResponse?> getNotifications() async {
    try {
      dynamic response =
      await _apiService.getResponse(ApiEndPoints.notifications);
      final jsonData = NotificationResponse.fromJson((response as ApiResponse).data);
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> toggleNotification(ToggleNotificationRequest request) async {
    try {
      dynamic response = await _apiService.updateRequest(ApiEndPoints.setNotification, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteNotification(String id) async {
    try {
      dynamic response = await _apiService.deleteRequest("${ApiEndPoints.deleteNotification}/$id", null);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> resendVerificationCode(ResendCodeRequest request) async {
    try {
      dynamic response = await _apiService.sendRequest(ApiEndPoints.resendVerificationCode, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> changePhoneNumber(ChangePhoneRequest request) async {
    try {
      dynamic response = await _apiService.sendRequest(ApiEndPoints.changePhone, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updatePhoneNumber(UpdatePhoneRequest request) async {
    try {
      dynamic response = await _apiService.sendRequest(ApiEndPoints.updatePhone, request);
      final jsonData = (response as ApiResponse).message ?? "";
      return jsonData;
    } catch (e) {
      rethrow;
    }
  }
}
