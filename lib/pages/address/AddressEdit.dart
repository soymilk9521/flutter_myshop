import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/AddressModelArgument.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/SaltService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressEditPage extends StatefulWidget {
  final AddressModelArgument arguments;
  static const String routeName = "/address_edit";
  AddressEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  AddressModelArgument _model = new AddressModelArgument();
  TextEditingController nameControler;
  TextEditingController addressControler;
  TextEditingController phoneControler;
  String _area = "";
  @override
  void initState() {
    super.initState();
    this._model = widget.arguments;
    nameControler = new TextEditingController();
    nameControler.text = widget.arguments.name;
    addressControler = new TextEditingController();
    addressControler.text = widget.arguments.address;
    phoneControler = new TextEditingController();
    phoneControler.text = widget.arguments.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑收货地址"),
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
              controller: nameControler,
            ),
            JdText(
              text: "收件人电话号码",
              onChanged: (val) {
                setState(() {
                  this._model.phone = val;
                });
              },
              controller: phoneControler,
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
              controller: addressControler,
              onChanged: (val) {
                setState(() {
                  this._model.address = this._area + val;
                });
              },
            ),
            SizedBox(height: 40),
            JdButton(
              text: "修改",
              cb: () async {
                String sign =
                    SaltService.getSign(this._model.toAddressEditSignJson());
                this._model.sign = sign;
                Dio dio = Dio();
                var url = '${Config.domain}api/editAddress';
                print("AddressEdit --> url --> $url");
                Response response = await dio.post(url,
                    data: this._model.toAddressEditDataJson());
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

                eventBus.fire(AddressEvent("地址修改成功..."));
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
