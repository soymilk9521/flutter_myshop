import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/services/CartService.dart';
import 'package:flutter_myshop/services/Storage.dart';

class CheckOutProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<CartModel> _cartItem = [];

  int cartCount() => this._cartItem.length;

  List<CartModel> cartItems() => this._cartItem;

  void updateCheckOutItem() async {
    List objResutl = [];
    List jsonResult = [];
    List result = json.decode(await Storage.getString(CartService.CARTLIST));
    result.forEach((element) {
      if (!element["checked"]) {
        objResutl.add(CartModel.fromJson(element));
      }
    });
    jsonResult = objResutl.map((value) {
      return value.toJson();
    }).toList();
    print("CheckOutProvider ---> 更新购物车商品 ---> $jsonResult");
    await Storage.setString(CartService.CARTLIST, json.encode(jsonResult));
    notifyListeners();
  }

  void getcheckOutItem() async {
    try {
      this._cartItem = [];
      List result = json.decode(await Storage.getString(CartService.CARTLIST));
      result.forEach((element) {
        if (element["checked"]) {
          this._cartItem.add(CartModel.fromJson(element));
        }
      });
    } catch (e) {
      print(e);
      this._cartItem = [];
    }
    notifyListeners();
  }

  double calcTotalAmount() {
    double total = 0;
    this._cartItem.forEach((el) {
      total += el.count * el.price;
    });
    return total;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', cartCount()));
  }
}
