import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';

class ProductTabCommentPage extends StatefulWidget {
  final ProductContentItemModel itemModel;
  ProductTabCommentPage(this.itemModel, {Key key}) : super(key: key);

  @override
  _ProductTabCommentPageState createState() => _ProductTabCommentPageState();
}

class _ProductTabCommentPageState extends State<ProductTabCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("商品评价"),
    );
  }
}
