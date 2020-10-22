import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';

class RegisterThirdPage extends StatefulWidget {
  static const String routeName = "/register_third";
  RegisterThirdPage({Key key}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  var _number;
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
            SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (val) {},
                  activeColor: Colors.red,
                ),
                Text(
                  "密码可见",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            JdButton(
              text: "完成",
              color:
                  ["", null].contains(this._number) ? Colors.grey : Colors.red,
              cb: () {
                Navigator.pushNamed(context, "");
              },
            ),
          ],
        ),
      ),
    );
  }
}
