import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/CateModel.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/pages/ProductList.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';
import 'package:flutter_myshop/config/Config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_myshop/widget/LoadingWidget.dart';

import '../Search.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  List<CateItemModel> _leftCateList = [];
  List<CateItemModel> _rightCateList = [];
  @override
  void initState() {
    super.initState();
    // 取得左侧分类数据
    _getLeftCateData();
  }

  // 取得左侧分类数据
  void _getLeftCateData() async {
    var dio = Dio();
    Response response = await dio.get('${Config.domain}api/pcate');
    CateModel result = CateModel.fromJson(response.data);

    ///setState(() {
    this._leftCateList = result.result;
    //});
    // 取得右侧分类数据
    if (this._leftCateList.length > 0) {
      _getRightCateData(this._leftCateList[0].sId);
    }
  }

  // 取得右侧分类数据
  void _getRightCateData(id) async {
    var dio = Dio();
    Response response = await dio.get('${Config.domain}api/pcate?pid=$id');
    CateModel result = CateModel.fromJson(response.data);
    if (mounted) {
      setState(() {
        this._rightCateList = result.result;
      });
    }
  }

  // 渲染左侧分类画面
  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        height: double.infinity,
        width: leftWidth,
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
                    width: double.infinity,
                    height: ScreenAdapter.height(90),
                    color: (this._selectedIndex == index)
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                    child: Text(
                      "${this._leftCateList[index].title}",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      this._selectedIndex = index;
                      // 动态渲染右侧分类画面
                      _getRightCateData(this._leftCateList[index].sId);
                    });
                  },
                ),
                Divider(
                  height: 1,
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        height: double.infinity,
        width: leftWidth,
      );
    }
  }

  // 渲染右侧分类画面
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth / rightItemHeight,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: this._rightCateList.length,
            itemBuilder: (context, index) {
              String pic = this._rightCateList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductListPage.routeName,
                    arguments: ProductArguments(
                      cId: this._rightCateList[index].sId,
                    ),
                  );
                },
                child: Container(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          "$pic",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: ScreenAdapter.height(32),
                        child: Text(
                          "${this._rightCateList[index].title}",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: LoadingWidget(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    double leftWidth = ScreenAdapter.getScreenWidth() / 4;
    double rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 10 * 2 - 10 * 2) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    double rightItemHeight = rightItemWidth + ScreenAdapter.height(32);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.center_focus_weak, color: Colors.black87, size: 28),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(76),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.search),
                Text(
                  "笔记本",
                  style: TextStyle(fontSize: ScreenAdapter.size(28)),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, SearchPage.routeName);
          },
        ),
        actions: [
          Icon(Icons.message, color: Colors.black87, size: 28),
          SizedBox(width: 10)
        ],
      ),
      body: Row(
        children: [
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth, rightItemHeight),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
