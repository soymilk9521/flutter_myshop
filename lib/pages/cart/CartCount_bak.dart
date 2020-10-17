import 'package:flutter/material.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class CartCountWidget extends StatelessWidget {
  const CartCountWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = context.watch<CartProvider>();
    return Container(
      child: Text(
        '${cartProvider.cartCount()}',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
