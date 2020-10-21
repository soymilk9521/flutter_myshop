import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/Search.dart';
import 'package:flutter_myshop/pages/tabs/Cart.dart';
import 'package:flutter_myshop/pages/tabs/Category.dart';
import 'package:flutter_myshop/pages/tabs/Home.dart';
import 'package:flutter_myshop/pages/tabs/User.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class Tabs extends StatefulWidget {
  static const root = "/";
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 3;
  PageController _pageController;
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];
  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      body: PageView(
        children: this._pageList,
        controller: this._pageController,
        onPageChanged: (value) {
          setState(() {
            this._currentIndex = value;
          });
        },
        // physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text("我的")),
        ],
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
