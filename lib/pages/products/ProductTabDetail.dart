import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ProductTabDetailPage extends StatefulWidget {
  final ProductContentItemModel itemModel;
  ProductTabDetailPage(this.itemModel, {Key key}) : super(key: key);

  @override
  _ProductTabDetailPageState createState() => _ProductTabDetailPageState();
}

class _ProductTabDetailPageState extends State<ProductTabDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          flex: 1,
          child: InAppWebView(
            initialUrl:
                "http://jd.itying.com/pcontent?id=${widget.itemModel.sId}",
            onProgressChanged: (controller, progress) {},
          ),
        ),
      ],
    ));
  }
}
