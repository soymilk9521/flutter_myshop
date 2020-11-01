import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/AddressModelArgument.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/pages/Pay.dart';
import 'package:flutter_myshop/pages/address/AddressList.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:flutter_myshop/provider/CheckOutProvider.dart';
import 'package:flutter_myshop/services/SaltService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/services/UserService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_myshop/services/EventBus.dart';

class CheckOutPage extends StatefulWidget {
  static const String routeName = "checkout";
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  AddressModelArgument _model = new AddressModelArgument();
  List _list = [];
  @override
  void initState() {
    super.initState();
    eventBus.on<AddressEditEvent>().listen((event) {
      print("CheckOut ---> AddressEditEvent ---> ${event.result}");
      this._initData();
    });
    this._initData();
  }

  void _initData() async {
    await UserService.getUserInfo().then((list) {
      if (list != null && list.length > 0) {
        this._model.uId = list[0]["_id"];
        this._model.salt = list[0]["salt"];
      }
    });
    String sign = SaltService.getSign(this._model.toAddressListSignJson());
    Dio dio = Dio();
    var url =
        '${Config.domain}api/oneAddressList?uid=${this._model.uId}&sign=$sign';
    print("CheckOut --> url --> $url");
    Response response = await dio.get(url);
    if (!response.data["success"]) {
      Fluttertoast.showToast(
          msg: "${response.data["message"]}!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (mounted) {
      setState(() {
        this._list = response.data["result"];
      });
    }
  }

  CheckOutProvider checkOutProvider;
  CartProvider cartProvider;

  Widget _checkOutItemWidget(CartModel item) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: ScreenAdapter.width(200),
              child: Image.network(
                "${item.pic}",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${item.selectedVal}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "￥${item.price}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("x${item.count}"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    checkOutProvider = Provider.of<CheckOutProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);

    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: Column(
                  children: [
                    this._list.length > 0
                        ? ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${this._list[0]["name"]} ${this._list[0]["phone"]}"),
                                Text("${this._list[0]["address"]}"),
                              ],
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AddressListPage.routeName);
                            },
                          )
                        : ListTile(
                            leading: Icon(Icons.add_location),
                            title: Center(
                              child: Text("请添加您的地址"),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AddressListPage.routeName);
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              checkOutProvider.cartCount() > 0
                  ? Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.white,
                      child: Column(
                        children: checkOutProvider.cartItems().map((el) {
                          return _checkOutItemWidget(el);
                        }).toList(),
                      ),
                    )
                  : Text(""),
              SizedBox(height: 10),
              checkOutProvider.cartCount() > 0
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("商品总金额：￥${checkOutProvider.calcTotalAmount()}"),
                          SizedBox(height: 10),
                          Text("立减：￥8"),
                        ],
                      ),
                    )
                  : Text(""),
            ],
          ),
          checkOutProvider.cartCount() > 0
              ? Positioned(
                  bottom: 0,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      width: ScreenAdapter.width(1200),
                      height: ScreenAdapter.height(100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 1, color: Colors.black12),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "实付款：￥${checkOutProvider.calcTotalAmount() - 8}",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              onPressed: () async {
                                if (this._list.length == 0) {
                                  Fluttertoast.showToast(
                                      msg: "请选择默认邮寄地址",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.pink,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                this._model.address = this._list[0]["address"];
                                this._model.name = this._list[0]["name"];
                                this._model.phone = this._list[0]["phone"];
                                this._model.allPrice =
                                    (checkOutProvider.calcTotalAmount() - 8)
                                        .toStringAsFixed(1);
                                List tempList = [];
                                checkOutProvider.cartItems().forEach((element) {
                                  tempList.add(element.toJson());
                                });
                                this._model.products = json.encode(tempList);
                                String sign = SaltService.getSign(
                                    this._model.toCheckOutSignJson());
                                this._model.sign = sign;
                                Dio dio = Dio();
                                var url = '${Config.domain}api/doOrder';
                                print("CheckOut --> url --> $url");
                                Response response = await dio.post(url,
                                    data: this._model.toCheckOutDataJson());
                                if (!response.data["success"]) {
                                  Fluttertoast.showToast(
                                      msg: "${response.data["message"]}!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.pink,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                await checkOutProvider.updateCheckOutItem();
                                await cartProvider.updateData();
                                Navigator.pushNamed(context, PayPage.routeName);
                              },
                              child: Text(
                                "立即下单",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )),
                )
              : Center(
                  child: Text("请选择您的宝!"),
                ),
        ],
      ),
    );
  }
}
