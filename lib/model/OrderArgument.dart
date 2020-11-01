import 'package:flutter_myshop/model/OrderModel.dart';

class OrderArgument {
  String uId;
  String sign;
  String salt;
  OrderModel model = OrderModel();

  OrderArgument({
    this.uId = "",
    this.sign = "",
    this.salt = "",
    this.model,
  });

  OrderArgument.fromJson(Map<String, dynamic> json) {
    uId = json['uid'];
    sign = json['sign'];
    salt = json['salt'];
  }

  // get sign for order list
  Map<String, dynamic> toOrderListSignJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['salt'] = this.salt;
    return data;
  }
}
