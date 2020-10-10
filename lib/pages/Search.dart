import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/pages/ProductList.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/search";
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _keywords;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(76),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            // autofocus: true,
            style: TextStyle(fontSize: ScreenAdapter.size(28)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
            ),
            onChanged: (value) {
              this._keywords = value;
            },
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              height: ScreenAdapter.height(76),
              width: ScreenAdapter.width(150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("搜索", style: TextStyle(fontSize: ScreenAdapter.size(32)))
                ],
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                ProductListPage.routeName,
                arguments: ProductArguments(keywords: this._keywords),
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: Text("热搜", style: Theme.of(context).textTheme.headline6),
            ),
            Divider(),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("笔记本电脑"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("女装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("男生皮鞋"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("白色家电"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("童装"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("百元商品"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("日用百货"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("建材"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                  ),
                  child: Text("中古"),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 50),
            Container(
              child: Text("历史记录", style: Theme.of(context).textTheme.headline6),
            ),
            Divider(),
            Column(
              children: [
                ListTile(
                  title: Text("大狗"),
                ),
                Divider(),
                ListTile(
                  title: Text("坦克300"),
                ),
                Divider(),
                ListTile(
                  title: Text("星途txl"),
                ),
                Divider(),
                ListTile(
                  title: Text("长城跑"),
                ),
                Divider(),
                ListTile(
                  title: Text("瑞虎8"),
                ),
                Divider(),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: ScreenAdapter.width(500),
              height: ScreenAdapter.height(80),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 1),
                  width: 1,
                ),
              ),
              child: OutlineButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      Text(
                        "清空历史记录",
                        style: TextStyle(
                          fontSize: ScreenAdapter.size(32),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
