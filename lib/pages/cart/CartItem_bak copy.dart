import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:provider/provider.dart';

// class CartItemWidget extends StatelessWidget {
//   final String title;
//   final Icon icon;
//   final Function cb;
//   CartItemWidget({
//     Key key,
//     this.title,
//     this.icon,
//     this.cb,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       trailing: InkWell(
//         child: icon,
//         onTap: (cb != null) ? cb() : null,
//       ),
//     );
//   }
// }

class CartItemWidget extends StatefulWidget {
  final String title;
  final Icon icon;
  final Function cb;
  CartItemWidget({Key key, this.title, this.icon, this.cb}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: cartProvider.cartItems().map((CartModel model) {
          return ListTile(
            title: CartModel.title().titleWidget,
            trailing: InkWell(
              child: model.iconWidget,
              onTap: () {
                if (model.function != null) {
                  model.function(model);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
