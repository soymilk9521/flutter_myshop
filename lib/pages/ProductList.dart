import 'package:flutter/material.dart';
import 'package:flutter_myshop/model/ProductArguments.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "/productList";
  final Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    final ProductArguments args = ModalRoute.of(context).settings.arguments;
    ScreenAdaper.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("商品列表"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 15,
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
        ));
  }
}
