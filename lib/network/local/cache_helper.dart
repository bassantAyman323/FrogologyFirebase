//for shared pref
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedpref;

  //at first
  static init() async {
    sharedpref = await SharedPreferences.getInstance();
  }

  //to put then get
  static Future<bool> putBoolean({
    @required String key,
    @required bool value,
  }) async {
    return await sharedpref.setBool(key, value);
  }

  static bool getBoolean({
    @required String key,
  }) {
    return sharedpref.getBool(key);
  }

  static Future<bool> putString({
    @required String key,
    @required String value,
  }) async {
    return await sharedpref.setString(key, value);
  }

  static String getString({
    @required String key,
  }) {
    return sharedpref.getString(key);
  }

  static Future<bool> saveData({
    @required String key,
    @required dynamic value,
  }) async {
    if (value is String) return await sharedpref.setString(key, value);
    if (value is int) return await sharedpref.setInt(key, value);
    if (value is bool) return await sharedpref.setBool(key, value);

    return await sharedpref.setDouble(key, value);
  }

  static Future<bool> removeData({
    @required String key,
  }) async {
    return await sharedpref.remove(key);
  }

  static dynamic getData({
    @required String key,
  }) {
    return sharedpref.get(key);
  }
}
