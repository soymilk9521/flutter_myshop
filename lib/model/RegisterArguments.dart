class RegisterArguments {
  String number;
  String code;
  String message;
  bool success;
  RegisterArguments({this.number, this.code, this.message, this.success});

  RegisterArguments.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
