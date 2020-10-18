import 'package:flutter/material.dart';

class CartModel {
  String sId;
  String title;
  String cid;
  Object price;
  String selectedVal;
  int count;
  String pic;
  bool checked;
  Text titleWidget;
  Icon iconWidget;
  Function function;

  CartModel({
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.selectedVal,
    this.count,
    this.pic,
    this.checked,
    this.titleWidget = const Text(""),
    this.iconWidget = const Icon(Icons.delete),
    this.function,
  });

  CartModel.title() {
    this.titleWidget = Text(this.title);
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    selectedVal = json['selectedVal'];
    count = json['count'];
    pic = json['pic'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['selectedVal'] = this.selectedVal;
    data['count'] = this.count;
    data['pic'] = this.pic;
    data['checked'] = this.checked;
    return data;
  }
}
