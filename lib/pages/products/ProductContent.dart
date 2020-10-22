import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductContentArguments.dart';
import 'package:flutter_myshop/model/ProductContentModel.dart';
import 'package:flutter_myshop/pages/products/ProductTabComment.dart';
import 'package:flutter_myshop/pages/products/ProductTabContent.dart';
import 'package:flutter_myshop/pages/products/ProductTabDetail.dart';
import 'package:flutter_myshop/pages/tabs/Cart.dart';
import 'package:flutter_myshop/provider/CartProvider.dart';
import 'package:flutter_myshop/services/CartService.dart';
import 'package:flutter_myshop/services/EventBus.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/widget/JdButton.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_myshop/widget/LoadingWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductContentPage extends StatefulWidget {
  static const routeName = "/productContent";
  final ProductContentArguments arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  CartProvider cartProvider;
  @override
  void initState() {
    super.initState();
    _getProductContentData();
  }

  ProductContentItemModel _itemModel;

  _getProductContentData() async {
    Dio dio = Dio();
    var url = '${Config.domain}api/pcontent?id=${widget.arguments.sId}';
    print("ProductContent --> url --> $url");
    Response response = await dio.get(url);
    ProductContentModel result = ProductContentModel.fromJson(response.data);

    setState(() {
      _itemModel = result.result;
      print("ProductContent --> pic --> ${_itemModel.pic}");
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    this.cartProvider = Provider.of<CartProvider>(context);
    // ProductContentArguments args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenAdapter.width(500),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(child: Text("商品")),
                    Tab(child: Text("详情")),
                    Tab(child: Text("评价")),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      ScreenAdapter.getScreenWidth() - 50, 80, 0, 10),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.home),
                          Text("首页"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.help),
                          Text("帮助"),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
        body: (this._itemModel != null)
            ? Stack(
                children: [
                  TabBarView(
                    children: [
                      ProductTabContentPage(this._itemModel),
                      ProductTabDetailPage(this._itemModel),
                      ProductTabCommentPage(this._itemModel),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.getScreenWidth(),
                    height: ScreenAdapter.height(130),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black26, width: 1),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.height(10)),
                            width: ScreenAdapter.width(120),
                            height: ScreenAdapter.height(120),
                            child: InkWell(
                              child: Column(
                                children: [
                                  Icon(Icons.shopping_cart, size: 30),
                                  Text("购物车"),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CartPage.routeName);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () async {
                                if (this._itemModel.attr.length > 0) {
                                  eventBus.fire(ProductContentEvent("加入购物车"));
                                } else {
                                  await CartService.addCart(this._itemModel);
                                  Navigator.pop(context);
                                  this.cartProvider.updateData();
                                  Fluttertoast.showToast(
                                      msg: "购物车添加成功!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.pink,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
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
                                eventBus.fire(ProductContentEvent("立即购买"));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : LoadingWidget(),
      ),
    );
  }
}
