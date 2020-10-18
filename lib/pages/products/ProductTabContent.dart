import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_myshop/pages/products/ProductCount.dart';
import 'package:flutter_myshop/services/CartService.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';

class ProductTabContentPage extends StatefulWidget {
  final ProductContentItemModel itemModel;
  ProductTabContentPage(this.itemModel, {Key key}) : super(key: key);

  @override
  _ProductTabContentPageState createState() => _ProductTabContentPageState();
}

class _ProductTabContentPageState extends State<ProductTabContentPage>
    with AutomaticKeepAliveClientMixin {
  List _attr = [];
  List _list = [];
  List _selectedValue = [];
  StreamSubscription<ProductContentEvent> sspBus;

  @override
  void initState() {
    super.initState();
    this._attr = widget.itemModel.attr;
    _rebuildDetailData();
    _getSelectedValue();
    sspBus = eventBus.on<ProductContentEvent>().listen((event) {
      print("ProductTabContent --> event --> ${event.result}");
      _showSeletedDetailWidget();
    });
  }

  @override
  void dispose() {
    super.dispose();
    sspBus.cancel();
  }

  _rebuildDetailData() {
    for (var i = 0; i < this._attr.length; i++) {
      List temp = this._attr[i].list.asMap().entries.map((entry) {
        int idx = entry.key;
        String title = entry.value;
        return {"checked": (idx == 0) ? true : false, "title": title};
      }).toList();
      this._list.add(temp);
    }
  }

  void _getSelectedValue() {
    setState(() {
      _selectedValue = [];

      this._list.forEach((subList) {
        subList.forEach((element) {
          if (element["checked"] == true) {
            _selectedValue.add(element["title"]);
          }
        });
      });

      widget.itemModel.selectedVal = _selectedValue.join(",");
    });
  }

  Widget _showAttrItemWidget(int index, Attr item, StateSetter myState) {
    // 数据组装
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
            children: this._list[index].map<Widget>((subItem) {
              return Container(
                margin: EdgeInsets.all(ScreenAdapter.width(20)),
                child: InkWell(
                  onTap: () {
                    myState(() {
                      subItem["checked"] = !subItem["checked"];
                      this._list[index].forEach((element) {
                        if (element["title"] != subItem["title"]) {
                          element["checked"] = false;
                        }
                      });
                      _getSelectedValue();
                    });
                    print("$index ----> ${this._list}");
                  },
                  child: Chip(
                    backgroundColor: subItem["checked"] ? Colors.red : null,
                    label: Text(
                      "${subItem['title']}",
                      style: TextStyle(
                        color: subItem["checked"] ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
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
        return StatefulBuilder(builder: (context, myState) {
          return GestureDetector(
            child: Stack(
              children: [
                ListView(
                  children: [
                    Column(
                      children: this._attr.asMap().entries.map((entry) {
                        int index = entry.key;
                        Attr item = entry.value;
                        return this._showAttrItemWidget(index, item, myState);
                      }).toList(),
                    ),
                    // 商品数量
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: ScreenAdapter.width(1200 / 4),
                            height: ScreenAdapter.height(100),
                            child: Text("数量")),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ProductCountWidget(widget.itemModel),
                          ),
                          flex: 1,
                        )
                      ],
                    )
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
                              CartService.addCart(widget.itemModel);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: JdButton(
                            color: Color.fromRGBO(255, 165, 0, 0.9),
                            text: "立即购买",
                            cb: () {
                              Navigator.pop(context);
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
        });
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
                  this._selectedValue.length > 0
                      ? Text("${this._selectedValue.join(',')}")
                      : Text(""),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
