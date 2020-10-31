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

  initData() async {
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

  updateData() async {
    initData();
  }

  void changeItem() async {
    result = this._cartItem.map((e) => e.toJson()).toList();
    print("CartProvider ---> changeItem ---> $result");
    await Storage.setString(CartService.CARTLIST, json.encode(result));
    notifyListeners();
  }

  deleteItem() async {
    this._cartItem.removeWhere((element) => element.checked);
    result = this._cartItem.map((e) => e.toJson()).toList();
    print("CartProvider ---> deleteItem ---> $result");
    await Storage.setString(CartService.CARTLIST, json.encode(result));
    notifyListeners();
  }

  bool isCheckAll() {
    return this._cartItem.every((element) => element.checked);
  }

  checkAll(value) async {
    print("----> $value");
    this._cartItem.forEach((element) => element.checked = value);
    result = this._cartItem.map((e) => e.toJson()).toList();
    print("CartProvider ---> checkAll ---> $result");
    await Storage.setString(CartService.CARTLIST, json.encode(result));
    notifyListeners();
  }

  double totalPrice() {
    double total = 0;
    this._cartItem.forEach((element) {
      if (element.checked) {
        total += element.count * element.price;
      }
    });
    return total;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', cartCount()));
  }
}
