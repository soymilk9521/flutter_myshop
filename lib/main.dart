import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/routes/routes.dart';
import 'package:flutter_myshop/pages/tabs/Tabs.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:flutter_myshop/provider/CheckOutProvider.dart';
import 'package:flutter_myshop/provider/UserProvider.dart';
import 'package:provider/provider.dart';
import 'provider/Counter.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => CheckOutProvider()),
    ],
    child: MyApp(),
  ));
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
      // initialRoute: LoginPage.routeName,
      initialRoute: Tabs.root,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}
