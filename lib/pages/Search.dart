import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/search";
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("查询页面"),
      ),
      body: Text("查询页面"),
    );
  }
}
