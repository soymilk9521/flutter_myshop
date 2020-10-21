import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  final Function onChanged;
  const JdText({
    Key key,
    this.text = "请输入",
    this.password = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: ScreenAdapter.height(76),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black26)),
      ),
      child: TextField(
        style: TextStyle(fontSize: ScreenAdapter.size(28)),
        obscureText: this.password,
        decoration: InputDecoration(
          hintText: this.text,
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: this.onChanged,
      ),
    );
  }
}
