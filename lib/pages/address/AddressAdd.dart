import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/widget/JdText.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAddPage extends StatefulWidget {
  static const String routeName = "/address_add";
  AddressAddPage({Key key}) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String _address = "";
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
            ),
            JdText(
              text: "收件人电话号码",
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
                      this._address.length > 0 ? this._address : "省/市/区",
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
                    this._address =
                        "${result.provinceName}/${result.cityName}/${result.areaName}";
                  });
                },
              ),
            ),
            JdText(
              text: "详细地址",
              height: 200,
              maxLines: 4,
            ),
            SizedBox(height: 40),
            JdButton(
              text: "添加",
              cb: () {
                print("添加");
              },
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
