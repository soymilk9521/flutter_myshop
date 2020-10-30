import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';

class PayPage extends StatefulWidget {
  static const String routeName = "/pay";
  PayPage({Key key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List _list = [
    {
      "name": "支付宝支付",
      "checked": true,
      "pic":
          "https://img.51miz.com/Element/00/82/29/99/8146f48b_E822999_de05ccc9.png",
    },
    {
      "name": "微信支付",
      "checked": false,
      "pic": "https://img.sj33.cn/uploads/allimg/201402/7-140223103130591.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("去支付"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: this._list.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          this._list[index]["pic"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text("${this._list[index]["name"]}"),
                      trailing: this._list[index]["checked"]
                          ? Icon(Icons.check, color: Colors.red)
                          : Text(""),
                      onTap: () {
                        setState(() {
                          this._list.forEach((e) {
                            if (this._list[index]["name"] == e["name"]) {
                              e["checked"] = true;
                            } else {
                              e["checked"] = false;
                            }
                          });
                        });
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
            Positioned(
              bottom: ScreenAdapter.height(100),
              width: ScreenAdapter.width(1160),
              height: ScreenAdapter.height(200),
              child: Container(
                alignment: Alignment.center,
                child: JdButton(
                  text: "支付",
                  color: Colors.red,
                  cb: () {
                    print("支付");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
