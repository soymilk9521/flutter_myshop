import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/AddressModelArgument.dart';
import 'package:flutter_myshop/provider/UserProvider.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/SaltService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddressAddPage extends StatefulWidget {
  static const String routeName = "/address_add";
  AddressAddPage({Key key}) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  AddressModelArgument _model = new AddressModelArgument();
  UserProvider userProvider;
  String _area = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("添加收货地址"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.height(10)),
        child: Column(
          children: [
            JdText(
              text: "收件人姓名",
              onChanged: (val) {
                setState(() {
                  this._model.name = val;
                });
              },
            ),
            JdText(
              text: "收件人电话号码",
              onChanged: (val) {
                setState(() {
                  this._model.phone = val;
                });
              },
            ),
            Container(
              height: ScreenAdapter.height(100),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black26),
                ),
              ),
              child: InkWell(
                child: Row(
                  children: [
                    Icon(Icons.add_location),
                    Text(
                      this._area.length > 0 ? this._area : "省/市/区",
                      style: TextStyle(fontSize: ScreenAdapter.size(36)),
                    ),
                  ],
                ),
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: Text(
                      "取消",
                      style: TextStyle(color: Colors.black),
                    ),
                    confirmWidget: Text(
                      "确定",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                  setState(() {
                    this._area =
                        "${result.provinceName}/${result.cityName}/${result.areaName}";
                  });
                },
              ),
            ),
            JdText(
              text: "详细地址",
              height: 200,
              maxLines: 4,
              onChanged: (val) {
                setState(() {
                  this._model.address = this._area + val;
                });
              },
            ),
            SizedBox(height: 40),
            JdButton(
              text: "添加",
              cb: () async {
                this._model.uId = this.userProvider.getUserId();
                this._model.salt = this.userProvider.getSalt();
                String sign =
                    SaltService.getSign(this._model.toAddressAddSignJson());
                this._model.sign = sign;
                Dio dio = Dio();
                var url = '${Config.domain}api/addAddress';
                print("AddressAdd --> url --> $url");
                Response response = await dio.post(url,
                    data: this._model.toAddressAddDataJson());
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

                eventBus.fire(AddressEvent("地址添加成功..."));
                eventBus.fire(AddressEditEvent("地址修改成功..."));
                Navigator.pop(context);
              },
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
