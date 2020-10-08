import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/model/ProductModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
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

  List<ProductItemModel> _productList = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
    String url =
        '${Config.domain}api/plist?cId=${args.cId}&page=${args.page}&sort=${args.sort}&pageSize=${args.pageSize}';
    print("url:$url");
    if (widget.arguments != null) {
      Response response = await dio.get(url);
      ProductModel result = ProductModel.fromJson(response.data);
      setState(() {
        if (result.result.length < args.pageSize) {
          args.hasMore = false;
        }
        this._productList.addAll(result.result);
        widget.arguments.page++;
        widget.arguments.flag = true;
      });
    }
  }

  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, ScreenAdaper.height(100), 10, 10),
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
                      width: ScreenAdaper.width(260),
                      height: ScreenAdaper.height(260),
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
                        height: ScreenAdaper.height(260),
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
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
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

  Widget _topBarWidget() {
    return Positioned(
      top: 0,
      child: Container(
          height: ScreenAdaper.height(90),
          width: ScreenAdaper.width(1200),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color.fromRGBO(233, 233, 233, 0.9),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(20), 0, ScreenAdaper.height(20)),
                    child: Text(
                      "综合",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(20), 0, ScreenAdaper.height(20)),
                    child: Text(
                      "价格",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(20), 0, ScreenAdaper.height(20)),
                    child: Text(
                      "热销",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(20), 0, ScreenAdaper.height(20)),
                    child: Text(
                      "筛选",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    this._scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _arguments = ModalRoute.of(context).settings.arguments;
    ScreenAdaper.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("商品列表"),
        actions: [
          Text(""),
        ],
      ),
      body: Stack(
        children: [
          _productListWidget(),
          _topBarWidget(),
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
