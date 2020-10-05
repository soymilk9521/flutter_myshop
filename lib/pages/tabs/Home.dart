import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/FocusModel.dart';
import 'package:flutter_myshop/model/ProductModel.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // 取得轮播图数据
    _getSwiperData();
    // 取得猜你喜欢数据
    _getHotProductData();
    // 取得热门商品数据
    _getBestProductData();
  }

  // List<Map> imgList = [
  //   {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
  //   {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
  //   {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
  // ];

  List<FocusItemModel> _swiperList = [];
  List<ProductItemModel> _hotProductList = [];
  List<ProductItemModel> _bestProductList = [];

  // 轮播图数据
  void _getSwiperData() async {
    var dio = Dio();
    Response response = await dio.get('${Config.domain}api/focus');
    var result = FocusModel.fromJson(response.data);

    setState(() {
      this._swiperList = result.result;
    });
  }

  // 猜你喜欢数据
  void _getHotProductData() async {
    var dio = Dio();
    Response response = await dio.get('${Config.domain}api/plist?is_hot=1');
    ProductModel result = ProductModel.fromJson(response.data);

    setState(() {
      this._hotProductList = result.result;
    });
  }

  // 热门商品数据
  void _getBestProductData() async {
    var dio = Dio();
    Response response = await dio.get('${Config.domain}api/plist?is_best=1');
    ProductModel result = ProductModel.fromJson(response.data);

    setState(() {
      this._bestProductList = result.result;
    });
  }

  // 轮播图组件画面描绘
  Widget _swiperWidget() {
    if (this._swiperList.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemCount: this._swiperList.length,
            itemBuilder: (context, index) {
              String pic = this._swiperList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Image.network(
                "$pic",
                fit: BoxFit.cover,
              );
            },
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text("");
    }
  }

  // 标题组件画面描绘
  Widget _titleWidget(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      height: ScreenAdaper.height(45),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdaper.width(10),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  // 猜你喜欢组件画面描绘
  Widget _hotProductsWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        height: ScreenAdaper.height(230),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this._hotProductList.length,
            itemBuilder: (contenx, index) {
              String pic = this._hotProductList[index].sPic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Column(
                children: [
                  Container(
                    height: ScreenAdaper.height(150),
                    width: ScreenAdaper.width(150),
                    margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
                    child: Image.network(
                      "$pic",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: ScreenAdaper.height(30),
                    child: Text("￥ ${this._hotProductList[index].price}"),
                  ),
                ],
              );
            }),
      );
    } else {
      return Text("");
    }
  }

  Widget _recProductItemWediget() {
    double itemWidth = (ScreenAdaper.width(ScreenAdaper.getScreenWidthPx()) -
            ScreenAdaper.width(20) * 3) /
        2;
    return Container(
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      child: Wrap(
        spacing: ScreenAdaper.width(20),
        runSpacing: ScreenAdaper.height(20),
        children: this._bestProductList.map((value) {
          String pic = value.sPic;
          pic = Config.domain + pic.replaceAll('\\', '/');
          return Container(
            width: itemWidth,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(ScreenAdaper.width(20)),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      "$pic",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(20),
                    ScreenAdaper.height(20),
                    ScreenAdaper.width(20),
                    0,
                  ),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdaper.width(20),
                      ScreenAdaper.height(20),
                      ScreenAdaper.width(20),
                      ScreenAdaper.height(10)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥ ${value.price}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "￥ ${value.oldPrice}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 初始化ScreenUtil组件
    ScreenAdaper.init(context);
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(height: ScreenAdaper.height(10)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdaper.height(10)),
        _hotProductsWidget(),
        _titleWidget("热门推荐"),
        SizedBox(height: ScreenAdaper.height(10)),
        _recProductItemWediget(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
