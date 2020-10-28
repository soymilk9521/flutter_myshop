class AddressModelArgument {
  String uId;
  String sign;
  String name;
  String phone;
  String address;
  String salt;

  AddressModelArgument({
    this.uId = "",
    this.sign = "",
    this.name = "",
    this.phone = "",
    this.address = "",
    this.salt = "",
  });

  AddressModelArgument.fromJson(Map<String, dynamic> json) {
    uId = json['uid'];
    name = json['name'];
    sign = json['sign'];
    salt = json['salt'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['sign'] = this.sign;
    data['salt'] = this.salt;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }

  Map<String, dynamic> toAddJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['salt'] = this.salt;
    return data;
  }

  Map<String, dynamic> toListJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uId;
    data['salt'] = this.salt;
    return data;
  }
}
