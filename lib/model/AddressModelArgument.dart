class AddressModelArgument {
  String sId;
  String uId;
  String sign;
  String name;
  String phone;
  String address;
  String salt;
  String allPrice;
  String products;

  AddressModelArgument({
    this.sId = "",
    this.uId = "",
    this.sign = "",
    this.name = "",
    this.phone = "",
    this.address = "",
    this.salt = "",
    this.allPrice = "",
    this.products = "",
  });

  AddressModelArgument.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uId = json['uid'];
    name = json['name'];
    sign = json['sign'];
    salt = json['salt'];
    address = json['address'];
    phone = json['phone'];
    allPrice = json['all_price'];
    products = json['products'];
  }

  // get sign for adding address
  Map<String, dynamic> toAddressAddSignJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['salt'] = this.salt;
    return data;
  }

  // add address data
  Map<String, dynamic> toAddressAddDataJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['sign'] = this.sign;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }

  // get sign for address list
  Map<String, dynamic> toAddressListSignJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['salt'] = this.salt;
    return data;
  }

  // get sign for changing default address
  Map<String, dynamic> toDefaultAddressSignJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['uid'] = this.uId;
    data['salt'] = this.salt;
    return data;
  }

  // change default address
  Map<String, dynamic> toDefaultAddressDataJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['uid'] = this.uId;
    data['sign'] = this.sign;
    return data;
  }

  // get sign for editing address
  Map<String, dynamic> toAddressEditSignJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['salt'] = this.salt;
    return data;
  }

  // edit address data
  Map<String, dynamic> toAddressEditDataJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['sign'] = this.sign;
    return data;
  }

  // get sign for checkout
  Map<String, dynamic> toCheckOutSignJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['all_price'] = this.allPrice;
    data['products'] = this.products;
    data['salt'] = this.salt;
    return data;
  }

  // checkout data
  Map<String, dynamic> toCheckOutDataJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['all_price'] = this.allPrice;
    data['products'] = this.products;
    data['sign'] = this.sign;
    return data;
  }
}
