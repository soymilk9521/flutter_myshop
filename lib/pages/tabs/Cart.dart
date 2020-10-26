import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/CheckOut.dart';
import 'package:flutter_myshop/pages/cart/CartItem.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:flutter_myshop/provider/CheckOutProvider.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routeName = "/cart";
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartProvider cartProvider;
  CheckOutProvider checkOutProvider;
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    cartProvider = Provider.of<CartProvider>(context);
    checkOutProvider = Provider.of<CheckOutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: [
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: () {
              setState(() {
                this._flag = !this._flag;

                print(this._flag);
              });
            },
          ),
        ],
        shadowColor: Colors.white,
      ),
      body: cartProvider.cartCount() > 0
          ? Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(120)),
                  child: ListView(
                    children: cartProvider
                        .cartItems()
                        .map((e) => CartItemWidget(e))
                        .toList(),
                  ),
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
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Row(
                              children: [
                                Checkbox(
                                  value: cartProvider.isCheckAll(),
                                  activeColor: Colors.pink,
                                  onChanged: (val) {
                                    cartProvider.checkAll(val);
                                  },
                                ),
                                Text("全选"),
                                SizedBox(width: 20),
                                Text("总价"),
                                Text(
                                  "${cartProvider.totalPrice()}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: this._flag
                              ? InkWell(
                                  child: Container(
                                    width: ScreenAdapter.width(300),
                                    height: ScreenAdapter.height(120),
                                    alignment: Alignment.center,
                                    color: Colors.red,
                                    child: Text("结算",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  onTap: () {
                                    print("结算");
                                    Navigator.pushNamed(
                                        context, CheckOutPage.routeName);
                                    checkOutProvider.getcheckOutItem();
                                  },
                                )
                              : InkWell(
                                  child: Container(
                                    width: ScreenAdapter.width(300),
                                    height: ScreenAdapter.height(120),
                                    alignment: Alignment.center,
                                    color: Colors.red,
                                    child: Text("删除",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  onTap: () {
                                    print("删除");
                                    cartProvider.deleteItem();
                                    Fluttertoast.showToast(
                                        msg: "商品删除成功!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.pink,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text("购物车空空如也!"),
            ),
    );
  }
}
