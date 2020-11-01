import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class OrderInfoPage extends StatefulWidget {
  static const String routeName = "/order_info";
  OrderInfoPage({Key key}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单详情"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.add_location),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("xxxx xxx"),
                  Text("xxx"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdapter.width(200),
                      child: Image.network(
                        "http://jd.itying.com/public/upload/Hfe1i8QDOkfVt-PuGcxCA0fs.jpg",
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
                              "xxxx",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "xxxxx",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "￥xxxx",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("xxxxx"),
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
                Row(
                  children: [
                    Container(
                      width: ScreenAdapter.width(200),
                      child: Image.network(
                        "http://jd.itying.com/public/upload/Hfe1i8QDOkfVt-PuGcxCA0fs.jpg",
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
                              "xxxx",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "xxxxx",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "￥xxxx",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("xxxxx"),
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
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("订单编号：xxxx"),
                SizedBox(height: 10),
                Text("下单日期：xxxx"),
                SizedBox(height: 10),
                Text("支付方式：xxxx"),
                SizedBox(height: 10),
                Text("配送方式：xxxx"),
                SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Text("总金额：￥9999"),
          )
        ],
      ),
    );
  }
}
