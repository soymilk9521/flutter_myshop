import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/order/OrderInfo.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = "/order";
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("订单列表"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            width: ScreenAdapter.height(1200),
            height: ScreenAdapter.width(100),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: Text("xxx", textAlign: TextAlign.center)),
                  Expanded(child: Text("xxx", textAlign: TextAlign.center)),
                  Expanded(child: Text("xxx", textAlign: TextAlign.center)),
                  Expanded(child: Text("xxx", textAlign: TextAlign.center)),
                  Expanded(child: Text("xxx", textAlign: TextAlign.center)),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(105)),
            child: ListView(
              children: [
                InkWell(
                  child: Card(
                    margin: EdgeInsets.all(ScreenAdapter.height(20)),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("订单编号：xxxxx"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Image.network(
                              "http://jd.itying.com/public/upload/Hfe1i8QDOkfVt-PuGcxCA0fs.jpg",
                              fit: BoxFit.cover),
                          title: Text("xxxxx"),
                          trailing: Text("xxxx"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text("合计：￥xxx"),
                          trailing: RaisedButton(
                            onPressed: () {
                              print("申请售后");
                            },
                            child: Text("申请售后"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, OrderInfoPage.routeName);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
