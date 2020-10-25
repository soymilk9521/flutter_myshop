import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/RegisterArguments.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  int _countdownTime = 0;
  int _maxCountTime = 10;
  RegisterArguments _arguments;

  @override
  void initState() {
    super.initState();
    setState(() {
      this._countdownTime = this._maxCountTime;
      this._arguments = widget.arguments;
    });
    //开始倒计时
    this._startCountdownTimer();
  }

  // 倒计时
  void _startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        this._countdownTime--;
        if (_countdownTime == 0) {
          timer.cancel();
        }
        print("---->$_countdownTime");
      });
    });
  }

  // 验证码校验
  bool _checkCode() =>
      RegExp(r"[a-zA-Z0-9]{4}$").hasMatch(this._code) &&
      this._code == widget.arguments.code;

  // 倒计时校验
  bool _checkTimer() => this._countdownTime == 0;

  // 重新获取验证码
  Future<void> _getValidationCode() async {
    String url = "${Config.domain}api/sendCode";
    Dio requet = Dio();
    Map data = {"tel": widget.arguments.number};
    var result = await requet.post(url, data: data);
    setState(() {
      _arguments = RegisterArguments.fromJson(result.data);
      _arguments.number = widget.arguments.number;
      widget.arguments.code = this._arguments.code;
    });
  }

  Future<bool> _checkValidationCode() async {
    String url = "${Config.domain}api/validateCode";
    Dio requet = Dio();
    Map data = {"tel": widget.arguments.number, "code": this._code};
    var result = await requet.post(url, data: data);
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
    return true;
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
                    color: Colors.black26,
                    child: this._checkTimer()
                        ? Text("重新发送")
                        : Text("${this._countdownTime}s"),
                  ),
                  onTap: this._checkTimer()
                      ? () async {
                          setState(() {
                            this._countdownTime = this._maxCountTime;
                          });
                          // 获取验证码
                          await this._getValidationCode();
                          // 开启倒计时
                          this._startCountdownTimer();
                        }
                      : null,
                ),
              ],
            ),
            SizedBox(height: 10),
            JdButton(
              text: "下一步",
              color: this._checkCode() ? Colors.red : Colors.grey,
              cb: this._checkCode()
                  ? () async {
                      var success = await _checkValidationCode();
                      print(this._arguments);
                      if (success) {
                        Navigator.pushNamed(
                          context,
                          RegisterThirdPage.routeName,
                          arguments: this._arguments,
                        );
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
