import 'dart:convert';
import 'package:base_flutter/constants/strings.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthMixin {

  static const String USER = "user";
  static const String TOKEN = "access_token";
  static const String IS_ON_BOARDED = "is_on_boarded";
  static const String LOGGED_IN = "is_logged_in";
  static const String TEMP_TOKEN = "temp_token";
  static const String NOTIFICATION_STATUS = "notification_status";
  static const String UNREAD_NOTIFICATION = "unread_notification";

  Future<void> saveProfile(SignedUser user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(USER, jsonEncode(user));
  }

  Future<SignedUser?> getProfile() async {
    var prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(USER);
    if(json == null) {
      return null;
    }
    return SignedUser.fromJson(jsonDecode(json));
  }

  Future<void> clearAuthToken() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN);
    prefs.remove(USER);
    prefs.remove(LOGGED_IN);
    prefs.remove(NOTIFICATION_STATUS);
  }



  Future<void> setOnBoarded(bool isOnBoarded) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_ON_BOARDED, isOnBoarded);
  }

  Future<bool> isOnBoarded() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_ON_BOARDED) ?? false;
  }

  Future<void> setIsLoggedIn(bool loggedIn) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN, loggedIn);
  }

  Future<bool> getIsLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LOGGED_IN) ?? false;
  }

  /// Saves the Temporary Token generated during Forgot Password flow
  Future<void> saveTempToken(String? token) async {
    if(token == null) return;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(TEMP_TOKEN, token);
  }

  /// Fetches the Temporary Token generated during Forgot Password flow
  Future<String?> getTempToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(TEMP_TOKEN);
    return token;
  }

  /// Saves the Notification Status
  Future<void> saveNotificationStatus(bool token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(NOTIFICATION_STATUS, token);
  }

  /// Fetches the Notification Status
  Future<bool> getNotificationStatus() async {
    var prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(NOTIFICATION_STATUS) ?? false;
    return status;
  }

  ///Set unread notification status
  Future<void> setUnreadNotification(bool isUnread) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(UNREAD_NOTIFICATION, isUnread);
  }

  ///Get unread notification status
  Future<bool> getUnreadNotification() async {
    var prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(UNREAD_NOTIFICATION) ?? false;
    return status;
  }

}