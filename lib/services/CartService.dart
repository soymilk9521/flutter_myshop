import 'dart:convert';

import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_myshop/services/Storage.dart';

class CartService {
  static const String CARTLIST = "cartList";

  static addCart(ProductContentItemModel itemModel) async {
    List<CartModel> objResult = [];
    List jsonResult = [];
    CartModel cart = formatCartData(itemModel);
    try {
      jsonResult = json.decode(await Storage.getString(CARTLIST));
      jsonResult.forEach((e) {
        objResult.add(CartModel.fromJson(e));
      });
      bool hasAdded = objResult.any((value) {
        if (value.sId == cart.sId && value.selectedVal == cart.selectedVal) {
          return true;
        }
        return false;
      });
      if (hasAdded) {
        // 购物车已添加该商品时
        jsonResult = objResult.map((value) {
          if (value.sId == cart.sId && value.selectedVal == cart.selectedVal) {
            value.count = value.count + cart.count;
          }
          return value.toJson();
        }).toList();
        print("CartService ---> 购物车已添加该商品时 ---> $jsonResult");
        await Storage.setString(CARTLIST, json.encode(jsonResult));
      } else {
        // 购物车未添加该商品时
        objResult.add(cart);
        jsonResult = objResult.map((e) => e.toJson()).toList();
        print("CartService ---> 购物车未添加该商品时 ---> $jsonResult");
        await Storage.setString(CARTLIST, json.encode(jsonResult));
      }
    } catch (e) {
      print(e);
      // 购物车为空时
      objResult.add(cart);
      jsonResult = objResult.map((e) => e.toJson()).toList();
      print("CartService ---> 购物车为空时 ---> $jsonResult");
      await Storage.setString(CARTLIST, json.encode(jsonResult));
    }
  }

  static CartModel formatCartData(ProductContentItemModel itemModel) {
    String pic = itemModel.pic;
    pic = Config.domain + pic.replaceAll("\\", "/");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = itemModel.sId;
    data['title'] = itemModel.title;
    data['cid'] = itemModel.cid;
    if (itemModel.price is String) {
      data['price'] = double.parse(itemModel.price);
    } else if (itemModel.price is int) {
      data['price'] = double.parse(itemModel.price.toString());
    } else {
      data['price'] = itemModel.price;
    }
    data['selectedVal'] = itemModel.selectedVal;
    data['count'] = itemModel.count;
    data['pic'] = pic;
    data['checked'] = true;

    print("CartService ---> formatCartData ---> $data");
    return CartModel.fromJson(data);
    ;
  }
}
