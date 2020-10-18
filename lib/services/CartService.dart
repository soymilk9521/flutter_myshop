import 'package:flutter_myshop/model/ProductContentModel.dart';

class CartService {
  static addCart(ProductContentItemModel itemModel) {
    Map<String, dynamic> map = formatCartData(itemModel);
    print("CartService ---> addCart ---> $map");
  }

  static Map<String, dynamic> formatCartData(
      ProductContentItemModel itemModel) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = itemModel.sId;
    data['title'] = itemModel.title;
    data['cid'] = itemModel.cid;
    data['price'] = itemModel.price;
    data['selectedVal'] = itemModel.selectedVal;
    data['count'] = itemModel.count;
    data['pic'] = itemModel.pic;
    data['checked'] = true;

    return data;
  }
}
