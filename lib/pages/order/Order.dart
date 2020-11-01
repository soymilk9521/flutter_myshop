import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/OrderArgument.dart';
import 'package:flutter_myshop/model/OrderModel.dart';
import 'package:flutter_myshop/pages/order/OrderInfo.dart';
import 'package:flutter_myshop/services/SaltService.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/services/UserService.dart';
import 'package:flutter_myshop/widget/LoadingWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderPage extends StatefulWidget {
  static const String routeName = "/order";
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderArgument _model = OrderArgument();
  List<OrderModel> _orderList = [];
  @override
  void initState() {
    super.initState();
    this._initData();
  }

  _initData() async {
    await UserService.getUserInfo().then((list) {
      if (list != null && list.length > 0) {
        this._model.uId = list[0]["_id"];
        this._model.salt = list[0]["salt"];
      }
    });
    String sign = SaltService.getSign(this._model.toOrderListSignJson());
    Dio dio = Dio();
    var url = '${Config.domain}api/orderList?uid=${this._model.uId}&sign=$sign';
    print("Order --> url -->$url");
    Response response = await dio.get(url);
    print(response);
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
    List result = response.data["result"];
    this._orderList = [];
    result.forEach((element) {
      if (mounted) {
        setState(() {
          this._orderList.add(OrderModel.fromJson(element));
        });
      }
    });
  }

  Widget _orderItemWidget(List<OrderItem> items) {
    return Column(
      children: items.map((item) {
        return ListTile(
          leading: Image.network("${item.productImg}", fit: BoxFit.cover),
          title: Text("${item.productTitle}"),
          trailing: Text("${item.productCount}"),
        );
      }).toList(),
    );
  }

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
                  Expanded(child: Text("全部", textAlign: TextAlign.center)),
                  Expanded(child: Text("待付款", textAlign: TextAlign.center)),
                  Expanded(child: Text("待收货", textAlign: TextAlign.center)),
                  Expanded(child: Text("已完成", textAlign: TextAlign.center)),
                  Expanded(child: Text("已取消", textAlign: TextAlign.center)),
                ],
              ),
            ),
          ),
          this._orderList.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(105)),
                  child: ListView.builder(
                      itemCount: this._orderList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                            margin: EdgeInsets.all(ScreenAdapter.height(20)),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      "订单编号：${this._orderList[index].sId}"),
                                ),
                                Divider(),
                                this._orderItemWidget(
                                    this._orderList[index].orderItem),
                                Divider(),
                                ListTile(
                                  leading: Text(
                                      "合计：￥${this._orderList[index].allPrice}"),
                                  trailing: RaisedButton(
                                    child: Text("申请售后"),
                                    onPressed: () {
                                      print("申请售后");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            this._model.model = this._orderList[index];
                            Navigator.pushNamed(
                              context,
                              OrderInfoPage.routeName,
                              arguments: this._model,
                            );
                          },
                        );
                      }),
                )
              : LoadingWidget(),
        ],
      ),
    );
  }
}
