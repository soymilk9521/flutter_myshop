import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/Search.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';

final routes = {
  "/": (context) => Tabs(),
  "/search": (context) => SearchPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
