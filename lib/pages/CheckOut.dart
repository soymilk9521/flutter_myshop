import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/provider/CheckOutProvider.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  static const String routeName = "checkout";
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  CheckOutProvider checkOutProvider;
  Widget _checkOutItemWidget(CartModel item) {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    checkOutProvider = Provider.of<CheckOutProvider>(context);
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
                      // ListTile(
                      //   leading: Icon(Icons.add_location),
                      //   title: Center(
                      //     child: Text("请添加您的地址"),
                      //   ),
                      //   trailing: Icon(Icons.keyboard_arrow_right),
                      // )
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("xxx"),
                            Text("xxx"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: checkOutProvider.cartItems().map((el) {
                      return _checkOutItemWidget(el);
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("商品总金额：￥100"),
                      SizedBox(height: 10),
                      Text("运费：￥0"),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
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
                          "总价：￥200",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            "立即下单",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}