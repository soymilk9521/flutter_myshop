import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/cart/CartItem.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: [IconButton(icon: Icon(Icons.launch), onPressed: null)],
        shadowColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              CartItemWidget(),
              CartItemWidget(),
              CartItemWidget(),
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.width(1200),
            height: ScreenAdapter.height(120),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Row(
                        children: [
                          Checkbox(value: true, onChanged: (val) {}),
                          Text("全选"),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Container(
                        width: ScreenAdapter.width(300),
                        height: ScreenAdapter.height(120),
                        alignment: Alignment.center,
                        color: Colors.red,
                        child:
                            Text("结算", style: TextStyle(color: Colors.white)),
                      ),
                      onTap: () {
                        print("结算");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
