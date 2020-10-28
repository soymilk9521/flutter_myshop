import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/AddressModelArgument.dart';
import 'package:flutter_myshop/pages/address/AddressAdd.dart';
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
      print(event.result);
      initData();
    });
    initData();
  }

  void initData() async {
    await UserService.getUserInfo().then((list) {
      if (list != null && list.length > 0) {
        setState(() {
          this._model.uId = list[0]["_id"];
          this._model.salt = list[0]["salt"];
        });
      }
    });
    String sign = SaltService.getSign(this._model.toListJson());
    Dio dio = Dio();
    print(this._model.uId);
    print(this._model.salt);
    var url =
        '${Config.domain}api/addressList?uid=${this._model.uId}&sign=$sign';
    print("AddressList --> url --> $url");
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
    setState(() {
      this._list = response.data["result"];
    });
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
            ListView.builder(
                itemCount: this._list.length,
                itemBuilder: (context, index) {
                  print(this._list[index]);
                  return Column(
                    children: [
                      ListTile(
                        leading: this._list[index]["default_address"] == 1
                            ? Icon(Icons.check, color: Colors.red)
                            : null,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${this._list[index]["name"]} ${this._list[index]["phone"]}"),
                            Text("${this._list[index]["address"]}"),
                          ],
                        ),
                        trailing: Icon(Icons.edit, color: Colors.blue),
                      ),
                      Divider(),
                    ],
                  );
                }),
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
