import 'package:flutter/material.dart';

class AddressEditPage extends StatefulWidget {
  static const String routeName = "/address_edit";
  AddressEditPage({Key key}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑收货地址"),
      ),
      body: Text("编辑收货地址"),
    );
  }
}
