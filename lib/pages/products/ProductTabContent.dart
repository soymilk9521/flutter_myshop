import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class ProductTabContentPage extends StatefulWidget {
  ProductTabContentPage({Key key}) : super(key: key);

  @override
  _ProductTabContentPageState createState() => _ProductTabContentPageState();
}

class _ProductTabContentPageState extends State<ProductTabContentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "https://www.itying.com/images/flutter/p1.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "联想（Lenovo）V110 14英寸手提便携轻薄笔记本电脑商务办公超极本笔记本电脑 9系A6独显款 8G内存 256G固态硬盘丨爆款 2G独显 黑色 14英寸 精装升级",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenAdapter.size(36),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "【联想V14-2020全新版，办公游戏两全其美】 新机型-十代酷睿强芯-MX330独显-FHD屏丨新品上市限时补贴200元神券，送价值199元套装，晒单领红包~",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: ScreenAdapter.size(28),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text("价格: "),
                        Text(
                          "￥2300",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenAdapter.size(48),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("原价: "),
                        Text(
                          "￥5000",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenAdapter.size(28),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: ScreenAdapter.height(100),
              child: Row(
                children: [
                  Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("115, 黑色, XL, 1件"),
                ],
              ),
            ),
            Divider(),
            Container(
              height: ScreenAdapter.height(100),
              child: Row(
                children: [
                  Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("免运费"),
                ],
              ),
            ),
            Divider(),
          ],
        ));
  }
}
