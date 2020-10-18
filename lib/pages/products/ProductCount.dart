import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class ProductCountWidget extends StatefulWidget {
  final ProductContentItemModel itemModel;
  ProductCountWidget(this.itemModel, {Key key}) : super(key: key);

  @override
  _ProductCountWidgetState createState() => _ProductCountWidgetState();
}

class _ProductCountWidgetState extends State<ProductCountWidget> {
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
      onTap: () {
        setState(() {
          if (widget.itemModel.count > 1) {
            widget.itemModel.count--;
          }
        });
      },
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
      onTap: () {
        setState(() {
          widget.itemModel.count++;
        });
      },
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
      child: Text("${widget.itemModel.count}"),
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
