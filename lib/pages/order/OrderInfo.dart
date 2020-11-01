import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/OrderArgument.dart';
import 'package:flutter_myshop/model/OrderModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class OrderInfoPage extends StatefulWidget {
  static const String routeName = "/order_info";
  final OrderArgument arguments;
  OrderInfoPage({Key key, this.arguments}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  List<Widget> _orderItemWidget(List<OrderItem> items) {
    List<Widget> list = [];
    items.forEach((OrderItem item) {
      var row = Row(
        children: [
          Container(
            width: ScreenAdapter.width(200),
            child: Image.network(
              "${item.productImg}",
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
                    "${item.productTitle}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${item.selectedAttr == null ? "" : item.selectedAttr}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥${item.productPrice}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item.productCount}"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
      list.add(row);
      list.add(Divider());
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
                  Text(
                      "${widget.arguments.model.name} ${widget.arguments.model.phone}"),
                  Text("${widget.arguments.model.address}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              children: this
                  ._orderItemWidget(widget.arguments.model.orderItem)
                  .map((e) => e)
                  .toList(),
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
            child: Text("总金额：￥${widget.arguments.model.allPrice}"),
          )
        ],
      ),
    );
  }
}
