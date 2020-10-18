import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/services/CartService.dart';
import 'package:flutter_myshop/services/Storage.dart';

class CartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  CartProvider() {
    initData();
  }

  List result = [];

  List<CartModel> _cartItem = [];

  int cartCount() => this._cartItem.length;

  List<CartModel> cartItems() => this._cartItem;

  void initData() async {
    try {
      this._cartItem = [];
      result = json.decode(await Storage.getString(CartService.CARTLIST));
      result.forEach((element) {
        this._cartItem.add(CartModel.fromJson(element));
      });
    } catch (e) {
      print(e);
      this._cartItem = [];
    }
    notifyListeners();
  }

  void updateData() {
    initData();
  }

  void changeItem() async {
    result = this._cartItem.map((e) => e.toJson()).toList();
    print("CartService ---> 购物车未添加该商品时 ---> $result");
    await Storage.setString(CartService.CARTLIST, json.encode(result));
    notifyListeners();
  }

  bool isCheckAll() {
    return this._cartItem.every((element) => element.checked);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', cartCount()));
  }
}
