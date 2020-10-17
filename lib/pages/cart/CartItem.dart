import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

import 'CartCount.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({Key key}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
              value: true,
              onChanged: (val) {
                print("checked");
              },
              activeColor: Colors.pink,
            ),
          ),
          Container(
            child: Image.network(
              "http://jd.itying.com/public/upload/Hfe1i8QDOkfVt-PuGcxCA0fs.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "七匹狼长袖衬衫男士2020秋季新品商务休闲翻领舒适衬衣男装职业装衬衫男寸衫衣服上衣 003(中灰)",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥6500",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartCountWidget(),
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
