import 'package:flutter/material.dart';

class CartModel {
  final Text title;
  final Icon icon;
  final Function function;
  CartModel({
    this.title = const Text(""),
    this.icon = const Icon(Icons.delete),
    this.function,
  });
}
