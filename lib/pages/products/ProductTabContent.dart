import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';

class ProductTabContentPage extends StatefulWidget {
  final ProductContentItemModel itemModel;
  ProductTabContentPage(this.itemModel, {Key key}) : super(key: key);

  @override
  _ProductTabContentPageState createState() => _ProductTabContentPageState();
}

class _ProductTabContentPageState extends State<ProductTabContentPage> {
  List _attr = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      this._attr = widget.itemModel.attr;
    });
  }

  Widget _showAttrItemWidget(Attr item) {
    return Wrap(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25),
          width: ScreenAdapter.width(1200 / 4),
          child: Text("${item.cate}"),
        ),
        Container(
          width: ScreenAdapter.width(1200 / 4 * 3),
          child: Wrap(
            children: item.list.map((subItem) {
              return Container(
                margin: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Chip(label: Text("$subItem")),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _showSeletedDetailWidget() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    children: this._attr.map((item) {
                      return this._showAttrItemWidget(item);
                    }).toList(),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: ScreenAdapter.height(120),
                  width: ScreenAdapter.width(1200),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: JdButton(
                          color: Color.fromRGBO(253, 1, 0, 0.9),
                          text: "加入购物车",
                          cb: () {
                            print("加入购物车1");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: JdButton(
                          color: Color.fromRGBO(255, 165, 0, 0.9),
                          text: "立即购买",
                          cb: () {
                            print("立即购买");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    String pic = "${widget.itemModel.pic}";
    pic = Config.domain + pic.replaceAll('\\', '/');
    print("ProductTabContent --> pic --> $pic");
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 16 / 12,
              child: Image.network(
                pic,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${widget.itemModel.title}",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenAdapter.size(36),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${widget.itemModel.subTitle}",
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
                          "￥${widget.itemModel.price}",
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
                          "￥${widget.itemModel.oldPrice}",
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
              child: InkWell(
                onTap: () {
                  _showSeletedDetailWidget();
                },
                child: Row(
                  children: [
                    Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("115, 黑色, XL, 1件"),
                  ],
                ),
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
