import 'package:flutter_myshop/login/Login.dart';
import 'package:flutter_myshop/login/RegisterFirst.dart';
import 'package:flutter_myshop/login/RegisterSecond.dart';
import 'package:flutter_myshop/login/RegisterThird.dart';
import 'package:flutter_myshop/model/AddressModelArgument.dart';
import 'package:flutter_myshop/model/OrderArgument.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/model/ProductContentArguments.dart';
import 'package:flutter_myshop/model/RegisterArguments.dart';
import 'package:flutter_myshop/pages/CheckOut.dart';
import 'package:flutter_myshop/pages/Pay.dart';
import 'package:flutter_myshop/pages/ProductList.dart';
import 'package:flutter_myshop/pages/Search.dart';
import 'package:flutter_myshop/pages/address/AddressAdd.dart';
import 'package:flutter_myshop/pages/address/AddressEdit.dart';
import 'package:flutter_myshop/pages/address/AddressList.dart';
import 'package:flutter_myshop/pages/order/Order.dart';
import 'package:flutter_myshop/pages/order/OrderInfo.dart';
import 'package:flutter_myshop/pages/products/ProductContent.dart';
import 'package:flutter_myshop/pages/tabs/Cart.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';
import 'package:flutter/material.dart';

final routes = {
  Tabs.root: (context) => Tabs(),
  SearchPage.routeName: (context) => SearchPage(),
  CartPage.routeName: (context) => CartPage(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterFirstPage.routeName: (context) => RegisterFirstPage(),
  CheckOutPage.routeName: (context) => CheckOutPage(),
  AddressAddPage.routeName: (context) => AddressAddPage(),
  AddressListPage.routeName: (context) => AddressListPage(),
  PayPage.routeName: (context) => PayPage(),
  OrderPage.routeName: (context) => OrderPage(),
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
  } else if (settings.name == ProductContentPage.routeName) {
    final ProductContentArguments arguments = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        return ProductContentPage(
          arguments: arguments,
        );
      },
    );
  } else if (settings.name == RegisterSecondPage.routeName) {
    final RegisterArguments arguments = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        return RegisterSecondPage(
          arguments: arguments,
        );
      },
    );
  } else if (settings.name == RegisterThirdPage.routeName) {
    final RegisterArguments arguments = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        return RegisterThirdPage(
          arguments: arguments,
        );
      },
    );
  } else if (settings.name == AddressEditPage.routeName) {
    final AddressModelArgument arguments = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        return AddressEditPage(
          arguments: arguments,
        );
      },
    );
  } else if (settings.name == OrderInfoPage.routeName) {
    final OrderArgument arguments = settings.arguments;
    return MaterialPageRoute(
      builder: (context) {
        return OrderInfoPage(
          arguments: arguments,
        );
      },
    );
  }
};
