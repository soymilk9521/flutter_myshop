import 'package:flutter/material.dart';
import 'package:flutter_myshop/login/RegisterFirst.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              print(value);
            },
          ),
          SizedBox(height: 10),
          JdText(
            text: "请输入密码",
            password: true,
            onChanged: (value) {
              print(value);
            },
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
            cb: () {
              print("登录");
            },
          ),
        ],
      ),
    );
  }
}
