import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/pages/ProductList.dart';
import 'package:flutter_myshop/pages/Search.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';
import 'package:flutter/material.dart';

final routes = {
  Tabs.root: (context) => Tabs(),
  SearchPage.routeName: (context) => SearchPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  if (settings.name == ProductListPage.routeName) {
    final ProductArguments arguments = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        return ProductListPage(
          arguments: arguments,
        );
      },
    );
  }
};