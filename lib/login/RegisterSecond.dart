import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/model/RegisterArguments.dart';
import 'package:flutter_myshop/services/RegisterService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';

import 'RegisterThird.dart';

class RegisterSecondPage extends StatefulWidget {
  static const String routeName = "/register_second";
  final RegisterArguments arguments;
  RegisterSecondPage({Key key, this.arguments}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  Timer _timer;
  String _code = "";
  int _maxCount = 60;
  int _countdownTime = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      this._countdownTime = this._maxCount;
    });
    //开始倒计时
    this._startCountdownTimer();
  }

  void _startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime--;
              print("---->$_countdownTime");
            }
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }

  bool _checkCode() {
    return RegisterService.checkCode(widget.arguments.code, this._code) &&
        _countdownTime != 0;
  }

  String _getValitionCode() {
    const String alphabet =
        '0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 4;

    /// 生成的字符串固定长度
    String tempcode = '';
    for (var i = 0; i < strlenght; i++) {
      tempcode = tempcode + alphabet[Random().nextInt(alphabet.length)];
    }
    return tempcode;
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
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
              child: Text(
                  "请输入${widget.arguments.number}收到的验证码：${widget.arguments.code}"),
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
                      setState(() {
                        this._code = value;
                      });
                      if (this._checkCode()) {
                        this._timer.cancel();
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                      LengthLimitingTextInputFormatter(4),
                    ],
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenAdapter.height(100),
                    width: ScreenAdapter.width(350),
                    color:
                        this._checkCode() ? Colors.green[200] : Colors.black26,
                    child: this._checkCode()
                        ? Text("验证成功")
                        : Text("重新发送(${this._countdownTime})"),
                  ),
                  onTap: this._checkCode()
                      ? null
                      : () {
                          if (_countdownTime == 0) {
                            setState(() {
                              this._countdownTime = this._maxCount;
                              widget.arguments.code = this._getValitionCode();
                            });
                            //开始倒计时
                            this._startCountdownTimer();
                          }
                        },
                ),
              ],
            ),
            SizedBox(height: 10),
            JdButton(
              text: "下一步",
              color: this._checkCode() ? Colors.red : Colors.grey,
              cb: this._checkCode()
                  ? () {
                      Navigator.pushNamed(context, RegisterThirdPage.routeName);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
