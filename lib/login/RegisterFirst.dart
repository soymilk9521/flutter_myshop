import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/RegisterArguments.dart';
import 'package:flutter_myshop/services/UserService.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'RegisterSecond.dart';

class RegisterFirstPage extends StatefulWidget {
  static const String routeName = "/register_first";
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String _number = "";
  RegisterArguments _arguments;

  Future<void> _getValidationCode() async {
    String url = "${Config.domain}api/sendCode";
    Dio requet = Dio();
    Map data = {"tel": this._number};
    var result = await requet.post(url, data: data);
    setState(() {
      _arguments = RegisterArguments.fromJson(result.data);
      _arguments.number = this._number;
    });
  }

  Widget _getTelCodeWidget() {
    return DropdownButton(
      underline: Container(height: 0), // 隐藏下划线
      items: [
        DropdownMenuItem(child: Text("+86")),
        DropdownMenuItem(child: Text("+81")),
        DropdownMenuItem(child: Text("+852")),
        DropdownMenuItem(child: Text("+853")),
        DropdownMenuItem(child: Text("+886")),
      ],
      onChanged: (val) {},
    );
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
          children: [
            JdText(
              text: "请输入手机号码",
              onChanged: (value) {
                setState(() {
                  this._number = value;
                });
              },
              icon: this._getTelCodeWidget(),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ], //只允许输入数字
              border: Border.all(width: 1, color: Colors.black26),
            ),
            SizedBox(height: 10),
            JdButton(
              text: "下一步",
              color: UserService.checkNumber(this._number)
                  ? Colors.red
                  : Colors.grey,
              cb: UserService.checkNumber(this._number)
                  ? () async {
                      await _getValidationCode();
                      if (this._arguments != null && this._arguments.success) {
                        Navigator.pushNamed(
                          context,
                          RegisterSecondPage.routeName,
                          arguments: this._arguments,
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "${this._arguments.message}!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.pink,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
