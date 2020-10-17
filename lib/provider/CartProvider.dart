import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_myshop/model/CartModel.dart';

class CartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<CartModel> _cartItem = [];

  void addItem(item) {
    this._cartItem.add(item);
    notifyListeners();
  }

  void removeItem(item) {
    this._cartItem.remove(item);
    notifyListeners();
  }

  int cartCount() => this._cartItem.length;

  List<CartModel> cartItems() => this._cartItem;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', cartCount()));
  }
}
