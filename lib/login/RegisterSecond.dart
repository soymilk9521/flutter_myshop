import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';

import 'RegisterThird.dart';

class RegisterSecondPage extends StatefulWidget {
  static const String routeName = "/register_second";
  RegisterSecondPage({Key key}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String _number;
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
              child: Text("请输入xxxxx收到的验证码："),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: ScreenAdapter.height(100),
                  width: ScreenAdapter.width(750),
                  child: JdText(
                    text: "请输入验证码",
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        this._number = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                    ],
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: ScreenAdapter.height(100),
                  width: ScreenAdapter.width(350),
                  color: Colors.black26,
                  child: Text("重新发送(113)"),
                ),
              ],
            ),
            SizedBox(height: 10),
            JdButton(
              text: "下一步",
              color:
                  ["", null].contains(this._number) ? Colors.grey : Colors.red,
              cb: () {
                Navigator.pushNamed(context, RegisterThirdPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
