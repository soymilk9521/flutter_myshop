import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class ProductTabCommentPage extends StatefulWidget {
  final ProductContentItemModel itemModel;
  ProductTabCommentPage(this.itemModel, {Key key}) : super(key: key);

  @override
  _ProductTabCommentPageState createState() => _ProductTabCommentPageState();
}

class _ProductTabCommentPageState extends State<ProductTabCommentPage> {
  List _list = [
    [
      {"checked": true, "title": "牛皮"}
    ],
    [
      {"checked": true, "title": "系带"}
    ],
    [
      {"checked": true, "title": "红色"},
      {"checked": true, "title": "白色"},
      {"checked": false, "title": "黄色"}
    ]
  ];
  List _attr = [];
  @override
  void initState() {
    super.initState();
    this._attr = widget.itemModel.attr;
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

  Widget _showAttrItemWidget(int index, Attr item) {
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
            children: this._list[index].asMap().entries.map<Widget>((entry) {
              int subIndex = entry.key;
              Map subItem = entry.value;
              return Container(
                margin: EdgeInsets.all(ScreenAdapter.width(20)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      this._list[index][subIndex]["checked"] =
                          !this._list[index][subIndex]["checked"];
                    });
                    print("($index,$subIndex) ----> ${this._list}");
                  },
                  child: Chip(
                    backgroundColor: this._list[index][subIndex]["checked"]
                        ? Colors.red
                        : null,
                    label: Text(
                      "${subItem['title']}",
                      style: TextStyle(
                        color: this._list[index][subIndex]["checked"]
                            ? Colors.white
                            : null,
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

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    int index = 2;
    return Container(
      child: ListView(
        children: [
          Column(
            children: this._attr.asMap().entries.map((entry) {
              int index = entry.key;
              Attr item = entry.value;
              return this._showAttrItemWidget(index, item);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
