import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:provider/provider.dart';
import 'CartCount.dart';

class CartItemWidget extends StatefulWidget {
  final CartModel item;
  CartItemWidget(this.item, {Key key}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  CartModel item;
  CartProvider cartProvider;
  @override
  void initState() {
    super.initState();
    setState(() {
      item = widget.item;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    cartProvider = Provider.of<CartProvider>(context);
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenAdapter.width(1200),
      height: ScreenAdapter.height(200),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Row(
        children: [
          Container(
            child: Checkbox(
              value: item.checked,
              onChanged: (val) {
                setState(() {
                  item.checked = val;
                  cartProvider.changeItem();
                });
              },
              activeColor: Colors.pink,
            ),
          ),
          Container(
            child: Image.network(
              "${item.pic}",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${item.selectedVal}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥${item.price}",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartCountWidget(item),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
