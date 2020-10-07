import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/model/ProductModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "/productList";
  ProductListPage({Key key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductArguments _arguments;
  List<ProductItemModel> _productList = [];

  void _getProductData() async {
    var dio = Dio();
    String url =
        '${Config.domain}api/plist?cId=${this._arguments.cId}&page=${this._arguments.page}&sort=${this._arguments.sort}';
    print(url);
    Response response = await dio.get(url);

    ProductModel result = ProductModel.fromJson(response.data);
    setState(() {
      this._productList.addAll(result.result);
    });
  }

  Widget _productListWidget() {
    print(this._productList.length);
    if (this._productList.length > 0) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, ScreenAdaper.height(100), 10, 10),
        child: ListView.builder(
          itemCount: this._productList.length,
          itemBuilder: (context, index) {
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
                          "https://www.itying.com/images/flutter/list2.jpg",
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
                              "gb好孩子 婴儿推车 新生儿 宝宝 手推车 可坐可躺 轻便折叠 双向推行 藏青C400-P303BBgb好孩子 婴儿推车 新生儿 宝宝 手推车 可坐可躺 轻便折叠 双向推行 藏青C400-P303BB",
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
                              "￥899",
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
              ],
            );
          },
        ),
      );
    } else {
      return LoadingWidget();
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
    _arguments = ModalRoute.of(context).settings.arguments;
    print(_arguments.cId);
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
