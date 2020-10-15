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

class _ProductTabContentPageState extends State<ProductTabContentPage>
    with AutomaticKeepAliveClientMixin {
  List _attr = [];
  List _list = [];
  List _selectedValue = [];
  @override
  void initState() {
    super.initState();
    this._attr = widget.itemModel.attr;
    _rebuildDetailData();
    getSelectedValue();
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

  void getSelectedValue() {
    setState(() {
      _selectedValue = [];
    });
    this._list.forEach((subList) {
      subList.forEach((element) {
        if (element["checked"] == true) {
          setState(() {
            _selectedValue.add(element["title"]);
          });
        }
      });
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
                      getSelectedValue();
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
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
