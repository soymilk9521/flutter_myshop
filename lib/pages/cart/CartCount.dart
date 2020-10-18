import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/CartModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class CartCountWidget extends StatefulWidget {
  final CartModel item;
  CartCountWidget(this.item, {Key key}) : super(key: key);

  @override
  _CartCountWidgetState createState() => _CartCountWidgetState();
}

class _CartCountWidgetState extends State<CartCountWidget> {
  CartModel item;
  @override
  void initState() {
    super.initState();
    setState(() {
      item = widget.item;
    });
  }

  Widget _leftBtnWidget() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(60),
        height: ScreenAdapter.height(60),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Text("-"),
      ),
      onTap: () {},
    );
  }

  Widget _rightBtnWidget() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(60),
        height: ScreenAdapter.height(60),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Text("+"),
      ),
      onTap: () {},
    );
  }

  Widget _centerWidget() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      height: ScreenAdapter.height(60),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Text("${item.count}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: ScreenAdapter.width(200),
      child: Row(
        children: [
          this._leftBtnWidget(),
          this._centerWidget(),
          this._rightBtnWidget()
        ],
      ),
    );
  }
}
