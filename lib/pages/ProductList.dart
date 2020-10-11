import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/model/ProductModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/services/SearchService.dart';
import 'package:flutter_myshop/widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "/productList";
  final ProductArguments arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _hasData = true;
  List<ProductItemModel> _productList = [];

  ScrollController _scrollController = ScrollController();

  TextEditingController _initTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTextController.text = widget.arguments.keywords;
    _getProductData();
    _scrollController.addListener(() {
      // _scrollController.position.pixels // 滚动条滚动位置
      // _scrollController.position.maxScrollExtent // 滚动条最大滚动位置
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (widget.arguments.flag && widget.arguments.hasMore) {
          _getProductData();
        }
      }
    });
  }

  void _getProductData() async {
    setState(() {
      widget.arguments.flag = false;
    });
    var dio = Dio();
    ProductArguments args = widget.arguments;
    String url = "";
    if (["", null, false, 0].contains(args.keywords)) {
      url =
          '${Config.domain}api/plist?cId=${args.cId}&page=${args.page}&sort=${args.sort}&pageSize=${args.pageSize}';
    } else {
      url =
          '${Config.domain}api/plist?search=${args.keywords}&page=${args.page}&sort=${args.sort}&pageSize=${args.pageSize}';
    }

    print("url --> $url");
    print("args --> $args");
    if (args != null) {
      Response response = await dio.get(url);
      ProductModel result = ProductModel.fromJson(response.data);

      setState(() {
        if (result.result.length == 0 && args.page == 1) {
          this._hasData = false;
        } else {
          this._hasData = true;
        }
        if (result.result.length < args.pageSize) {
          args.hasMore = false;
        }
        this._productList.addAll(result.result);
        widget.arguments.page++;
        widget.arguments.flag = true;
      });
    } else {
      this._hasData = false;
    }
  }

  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, ScreenAdapter.height(100), 10, 10),
        child: ListView.builder(
          controller: this._scrollController,
          itemCount: this._productList.length,
          itemBuilder: (context, index) {
            // 图片处理
            String pic = this._productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdapter.width(260),
                      height: ScreenAdapter.height(260),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        height: ScreenAdapter.height(260),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${this._productList[index].title}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("126"),
                                )
                              ],
                            ),
                            Text(
                              "￥${this._productList[index].price}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(),
                _showBottomWidget(index),
              ],
            );
          },
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _showBottomWidget(index) {
    if (widget.arguments.hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text("");
    } else {
      return (index == this._productList.length - 1)
          ? Text("-- 我是有底线的 --")
          : Text("");
    }
  }

  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1, "showIcon": false},
    {
      "id": 2,
      "title": "销量",
      "fileds": "salecount",
      "sort": -1,
      "showIcon": true
    },
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1, "showIcon": true},
    {"id": 4, "title": "筛选", "showIcon": false},
  ];

  int _selectedHeaderId = 1;
  void _subHeaderChange(id) {
    if (id == 4) {
      this._scaffoldKey.currentState.openEndDrawer();
    } else {
      setState(() {
        this._selectedHeaderId = id;
        // 重置排序
        widget.arguments.sort =
            "${this._subHeaderList[id - 1]["fileds"]}_${this._subHeaderList[id - 1]["sort"]}";
        // 再次点击倒序排列
        this._subHeaderList[id - 1]["sort"] =
            this._subHeaderList[id - 1]["sort"] * -1;
        // 重置分页
        widget.arguments.page = 1;
        // 重置列表
        this._productList = [];
        // 重置hasMore
        widget.arguments.hasMore = true;
        // 重置滚动条
        if (this._hasData) {
          this._scrollController.jumpTo(0);
        }
      });
      // 重新获取数据
      this._getProductData();
    }
  }

  Widget _showTitleIconWidget(e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          e["title"],
          textAlign: TextAlign.center,
          style: TextStyle(
            color:
                (this._selectedHeaderId == e["id"]) ? Colors.red : Colors.black,
          ),
        ),
        (e["showIcon"])
            ? (e["sort"] > 0
                ? Icon(Icons.arrow_drop_down)
                : Icon(Icons.arrow_drop_up))
            : Text(""),
      ],
    );
  }

  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      child: Container(
        height: ScreenAdapter.height(90),
        width: ScreenAdapter.width(1200),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(233, 233, 233, 0.9),
            ),
          ),
        ),
        child: Row(
          children: this._subHeaderList.map((e) {
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                  child: _showTitleIconWidget(e),
                ),
                onTap: () {
                  _subHeaderChange(e["id"]);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _arguments = ModalRoute.of(context).settings.arguments;
    ScreenAdapter.init(context);
    return Scaffold(
      key: _scaffoldKey,
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
            controller: _initTextController,
            style: TextStyle(fontSize: ScreenAdapter.size(28)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
            ),
            onChanged: (value) {
              widget.arguments.keywords = value;
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
              _subHeaderChange(1);
              SearchService.setHistoryList(widget.arguments.keywords);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          this._hasData
              ? _productListWidget()
              : Center(child: Text("没有您要浏览的数据!")),
          _subHeaderWidget(),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Text("侧边栏"),
        ),
      ),
    );
  }
}
