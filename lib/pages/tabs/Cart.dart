import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/pages/ProductList.dart';
import 'package:flutter_myshop/pages/Search.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Column(
      children: [
        RaisedButton(
          child: Text("Go To Search"),
          onPressed: () {
            Navigator.pushNamed(context, SearchPage.routeName);
          },
        ),
        RaisedButton(
          child: Text("Go To ProductList"),
          onPressed: () {
            Navigator.pushNamed(
              context,
              ProductListPage.routeName,
              arguments: ProductArguments(
                sId: "123456",
              ),
            );
          },
        ),
      ],
    );
  }
}
