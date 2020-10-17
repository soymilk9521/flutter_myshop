import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/pages/cart/CartCount_bak.dart';
import 'package:flutter_myshop/pages/cart/CartItem.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeCartItem(CartModel item) {
    print("---> $item");
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    setState(() {
      cartProvider.removeItem(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = this.context.watch<CartProvider>();
    ScreenAdapter.init(context);
    return Scaffold(
      body: Stack(
        children: [
          CartItemWidget(),
          Positioned(
              bottom: 0,
              width: ScreenAdapter.width(120),
              height: ScreenAdapter.height(120),
              child: Chip(
                label: CartCountWidget(),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            cartProvider.addItem(
              CartModel(
                title: Text("商品"),
                function: _removeCartItem,
              ),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
