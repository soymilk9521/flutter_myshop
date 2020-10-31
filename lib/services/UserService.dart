import 'dart:convert';

import 'package:flutter_myshop/services/Storage.dart';

class UserService {
  static const String USERINFO = "userinfo";
  // 以1开头的11位手机号校验
  static bool checkNumber(String str) => RegExp(r"^1[0-9]{10}$").hasMatch(str);

  static Future<void> setUserInfo(Map result) async {
    if (result != null && result[USERINFO] != null) {
      await Storage.setString(USERINFO, json.encode(result[USERINFO]));
    }
  }

  static Future<List> getUserInfo() async {
    try {
      List userInfo = json.decode(await Storage.getString(USERINFO));
      return userInfo;
    } catch (e) {
      return [];
    }
  }

  static Future<void> removeUserInfo() async {
    await Storage.remove(USERINFO);
  }
}
