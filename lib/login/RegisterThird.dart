import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/RegisterArguments.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';
import 'package:flutter_myshop/services/RegisterService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterThirdPage extends StatefulWidget {
  static const String routeName = "/register_third";

  final RegisterArguments arguments;
  RegisterThirdPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String _password;
  bool _visible = true;

  Future<bool> _register() async {
    if (this._password.length < 6 || this._password.length > 20) {
      Fluttertoast.showToast(
          msg: "密码长度必须是6-20个字符!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    String url = "${Config.domain}api/register";
    Dio requet = Dio();

    Map data = {
      "tel": widget.arguments.number,
      "code": widget.arguments.code,
      "password": this._password
    };
    var result = await requet.post(url, data: data);
    print("RegisterThird ---> register ---> $result");

    if (!result.data["success"]) {
      Fluttertoast.showToast(
          msg: "${result.data['message']}!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    RegisterService.setUserInfo(result.data);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手机快速注册"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text("请设置登录密码："),
            ),
            SizedBox(height: 10),
            Container(
              height: ScreenAdapter.height(100),
              width: double.infinity,
              child: JdText(
                text: "请设置6-20位字符",
                onChanged: (value) {
                  setState(() {
                    this._password = value;
                  });
                },
                password: this._visible,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp("[ZA-ZZa-z0-9_#-]+")),
                ],
                border: Border.all(width: 1, color: Colors.black26),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: this._visible,
                  activeColor: Colors.red,
                  onChanged: (val) {
                    setState(() {
                      this._visible = val;
                    });
                  },
                ),
                Text(
                  "密码可见",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            JdButton(
              text: "完成",
              color: ["", null].contains(this._password)
                  ? Colors.grey
                  : Colors.red,
              cb: () async {
                bool success = await _register();
                if (success) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Tabs()),
                    (route) => route == null,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
