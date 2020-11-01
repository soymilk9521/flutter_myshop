import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myshop/login/Login.dart';
import 'package:flutter_myshop/pages/order/Order.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/UserService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List _userInfo = [];
  StreamSubscription<LoginEvent> bus;
  @override
  void initState() {
    super.initState();
    UserService.getUserInfo().then((value) {
      print("user ---> init ---> $value");
      if (mounted) {
        setState(() {
          _userInfo = value;
        });
      }
    });

    bus = eventBus.on<LoginEvent>().listen((event) {
      print("user --> event --> ${event.result}");
      UserService.getUserInfo().then((value) {
        setState(() {
          _userInfo = value;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    bus.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: ScreenAdapter.height(400),
            width: ScreenAdapter.width(1200),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/user_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset(
                      "images/user.png",
                      fit: BoxFit.cover,
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: (this._userInfo.length == 0)
                      ? InkWell(
                          child: Container(
                            child: Text(
                              "登录/注册",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdapter.size(36),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, LoginPage.routeName);
                          },
                        )
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "用户名：${this._userInfo[0]['username']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.size(36),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "普通会员",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.size(24),
                                ),
                              )
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text("全部订单"),
            onTap: () {
              Navigator.pushNamed(context, OrderPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text("待付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text("待收货"),
          ),
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(20),
            color: Colors.black12,
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text("我的收藏"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text("在线客服"),
          ),
          Divider(),
          SizedBox(height: 100),
          _userInfo.length > 0
              ? JdButton(
                  text: "退出登录",
                  color: Colors.red,
                  cb: () {
                    print("退出登录");
                    UserService.removeUserInfo();
                    eventBus.fire(LoginEvent("退出成功!"));
                  },
                )
              : Text(""),
        ],
      ),
    );
  }
}
