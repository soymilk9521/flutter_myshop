import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/model/RegisterArguments.dart';
import 'package:flutter_myshop/services/RegisterService.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';

import 'RegisterSecond.dart';

class RegisterFirstPage extends StatefulWidget {
  static const String routeName = "/register_first";
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String _number = "";

  Widget _getIconWidget() {
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
                print(value);
                setState(() {
                  this._number = value;
                });
              },
              icon: this._getIconWidget(),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ], //只允许输入数字
              border: Border.all(width: 1, color: Colors.black26),
            ),
            SizedBox(height: 10),
            JdButton(
              text: "下一步",
              color: RegisterService.checkNumber(this._number)
                  ? Colors.red
                  : Colors.grey,
              cb: RegisterService.checkNumber(this._number)
                  ? () {
                      Navigator.pushNamed(
                        context,
                        RegisterSecondPage.routeName,
                        arguments: RegisterArguments(
                          number: this._number,
                          code: "1120",
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
