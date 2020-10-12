import 'package:flutter/material.dart';

class ProductTabDetailPage extends StatefulWidget {
  ProductTabDetailPage({Key key}) : super(key: key);

  @override
  _ProductTabDetailPageState createState() => _ProductTabDetailPageState();
}

class _ProductTabDetailPageState extends State<ProductTabDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("这是第$index项目"),
          );
        },
      ),
    );
  }
}
