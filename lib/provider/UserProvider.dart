import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_myshop/services/Storage.dart';
import 'package:flutter_myshop/services/UserService.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List _userInfo = [];
  UserProvider() {
    this._initData();
  }

  void _initData() async {
    this._userInfo = json.decode(await Storage.getString(UserService.USERINFO));
    notifyListeners();
  }

  List userInfo() => this._userInfo.length > 0 ? this._userInfo : [];

  String getUserId() {
    if (this._userInfo.length > 0) {
      return this._userInfo[0]["_id"];
    }
    return null;
  }

  String getSalt() {
    if (this._userInfo.length > 0) {
      return this._userInfo[0]["salt"];
    }
    return null;
  }
}
