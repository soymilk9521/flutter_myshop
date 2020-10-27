import 'package:flutter/material.dart';
import 'package:flutter_myshop/pages/address/AddressAdd.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class AddressListPage extends StatefulWidget {
  static const String routeName = "/address_list";
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.height(10)),
        child: Stack(
          children: [
            ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.check, color: Colors.red),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("xxxxxx"),
                      Text("xxxxx"),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
                ListTile(
                  leading: 1 != 1 ? Icon(Icons.check, color: Colors.red) : null,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("xxxxxx"),
                      Text("xxxxx"),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
                ListTile(
                  leading: 1 != 1 ? Icon(Icons.check, color: Colors.red) : null,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("xxxxxx"),
                      Text("xxxxx"),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
                ListTile(
                  leading: 1 != 1 ? Icon(Icons.check, color: Colors.red) : null,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("xxxxxx"),
                      Text("xxxxx"),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: ScreenAdapter.height(100),
                width: ScreenAdapter.width(1200),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black26),
                  ),
                  color: Colors.red,
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_location, color: Colors.white),
                      Text("添加收获地址", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AddressAddPage.routeName);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
