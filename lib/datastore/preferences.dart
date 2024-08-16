import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/model/user_data_model.dart';
import 'package:shortnews/view/uitl/app_string.dart';

class Preferences with ChangeNotifier {
  Future<bool> saveUser(UserData data) async {
    // Obtain shared preferences.

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStringFile.USER_TOKEN, data.user_token);
    await prefs.setString(AppStringFile.USER_ID, data.user_id);
    await prefs.setString(AppStringFile.USER_EMAIL, data.user_email);
    await prefs.setString(AppStringFile.USER_ADDRESS, data.user_name);
    await prefs.setString(AppStringFile.USER_NAME, data.user_name);

    notifyListeners();
    return true;
  }

  /// CLEAR_PREFERENCE_DATA
  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStringFile.USER_ID, '');
    await prefs.setString(AppStringFile.USER_TOKEN, '');
    await prefs.setString(AppStringFile.USER_EMAIL, '');
    await prefs.setString(AppStringFile.USER_ADDRESS, '');
    await prefs.setString(AppStringFile.USER_NAME, '');

    notifyListeners();
  }

  /// SAVE_USER_AUTHENTICATION

  /// SAVE_APP_IN_ENGLISH
  // Future<User> getUser() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   print("lknvbvbjnn  ${AppStringFile.USER_NAME}");
  //   return User(
  //     id: prefs.getInt(AppStringFile.USER_ID) ?? 0,
  //     employeeCode: prefs.getString(AppStringFile.USER_EMP_CODE) ?? "",
  //     mail: prefs.getString(AppStringFile.USER_EMAIL) ?? "",
  //     fullName: prefs.getString(AppStringFile.USER_NAME) ?? "",
  //     avatar: prefs.getString(AppStringFile.USER_AVATAR) ?? "",
  //   );
  // }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppStringFile.USER_TOKEN) ?? '';
  }

  ///USER_ID
  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

     print("check userId  ${prefs.getString(AppStringFile.USER_ID)}");
    return prefs.getString(AppStringFile.USER_ID) ?? '';
  }

  /// GET_USER_AUTH

  /// GET_EMAIL
}
