import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/ProductList.dart';
import 'package:flutter_myshop/pages/products/ProductContent.dart';
import 'package:flutter_myshop/pages/routes/routes.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ProductContentPage.routeName,
      // initialRoute: ProductListPage.routeName,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}
