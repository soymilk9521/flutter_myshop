import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/AddressModelArgument.dart';
import 'package:flutter_myshop/pages/address/AddressAdd.dart';
import 'package:flutter_myshop/pages/address/AddressEdit.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/SaltService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/services/UserService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressListPage extends StatefulWidget {
  static const String routeName = "/address_list";
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  AddressModelArgument _model = new AddressModelArgument();
  List _list = [];
  @override
  void initState() {
    super.initState();
    eventBus.on<AddressEvent>().listen((event) {
      print("AddressList ---> AddressEvent ---> ${event.result}");
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
        '${Config.domain}api/addressList?uid=${this._model.uId}&sign=$sign';
    print("AddressList --> url -->$url");
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

  void _changeDefaultAddress(String id) async {
    this._model.sId = id;
    String sign = SaltService.getSign(this._model.toDefaultAddressSignJson());
    this._model.sign = sign;
    Dio dio = Dio();
    var url = '${Config.domain}api/changeDefaultAddress';
    print("AddressList --> url -->$url");
    Response response =
        await dio.post(url, data: this._model.toDefaultAddressDataJson());
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

    eventBus.fire(AddressEditEvent("设置默认地址成功!"));
    Navigator.pop(context);
  }

  void _deleteAddres(String id) async {
    this._model.sId = id;
    String sign = SaltService.getSign(this._model.toDefaultAddressSignJson());
    this._model.sign = sign;
    Dio dio = Dio();
    var url = '${Config.domain}api/deleteAddress';
    print("AddressList --> url -->$url");
    Response response =
        await dio.post(url, data: this._model.toDefaultAddressDataJson());
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
    this._initData();
    eventBus.fire(AddressEditEvent("删除地址成功!"));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.height(10)),
        child: Stack(
          children: [
            this._list.length != 0
                ? ListView.builder(
                    itemCount: this._list.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: this._list[index]["default_address"] == 1
                                ? Icon(Icons.check, color: Colors.red)
                                : null,
                            title: InkWell(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${this._list[index]["name"]} ${this._list[index]["phone"]}"),
                                  Text("${this._list[index]["address"]}"),
                                ],
                              ),
                              onTap: () {
                                this._changeDefaultAddress(
                                  this._list[index]["_id"],
                                );
                              },
                              onLongPress: () async {
                                await showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("提示信息"),
                                      content: Text("您确定删除吗？"),
                                      actions: [
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("取消"),
                                        ),
                                        FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            _deleteAddres(
                                              this._list[index]["_id"],
                                            );
                                          },
                                          child: Text("确定"),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  this._model.sId = this._list[index]["_id"];
                                  this._model.name = this._list[index]["name"];
                                  this._model.address =
                                      this._list[index]["address"];
                                  this._model.phone =
                                      this._list[index]["phone"];
                                  Navigator.pushNamed(
                                    context,
                                    AddressEditPage.routeName,
                                    arguments: this._model,
                                  );
                                }),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text("未添加默认地址!"),
                  ),
            Positioned(
              bottom: 0,
              child: Container(
                height: ScreenAdapter.height(100),
                width: ScreenAdapter.width(1200),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black26),
                  ),
                  color: Colors.red,
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_location, color: Colors.white),
                      Text("添加收获地址", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AddressAddPage.routeName);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
