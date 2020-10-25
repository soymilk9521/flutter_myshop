import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/login/RegisterFirst.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/RegisterService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;

  void _login() async {
    if (!["", null].contains(this._password) &&
        !["", null].contains(this._username)) {
      String url = "${Config.domain}api/doLogin";
      Dio requet = Dio();

      Map data = {
        "username": this._username,
        "password": this._password,
      };
      var result = await requet.post(url, data: data);
      print("login ---> login ---> $result");
      if (result.data["success"]) {
        RegisterService.setUserInfo(result.data);
        Navigator.pop(context);
        eventBus.fire(LoginEvent("登录成功!"));
      } else {
        Fluttertoast.showToast(
            msg: "${result.data["success"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "用户名或密码不能为空!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          FlatButton(onPressed: () {}, child: Text("客服")),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: ScreenAdapter.height(300),
              width: ScreenAdapter.width(300),
              child: Image.asset("images/incaration.png", fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 20),
          JdText(
            text: "用户名/手机号",
            onChanged: (value) {
              this._username = value;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[ZA-ZZa-z0-9]"))
            ],
          ),
          SizedBox(height: 10),
          JdText(
            text: "请输入密码",
            password: true,
            onChanged: (value) {
              this._password = value;
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[ZA-ZZa-z0-9_#-]+")),
            ],
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  onPressed: () {},
                  child: Text("忘记密码"),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterFirstPage.routeName);
                  },
                  child: Text("新用户注册"),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          JdButton(
            text: "登录",
            height: 80,
            color: Colors.red,
            cb: this._login,
          ),
        ],
      ),
    );
  }
}
