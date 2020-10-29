import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  final Function onChanged;
  final Widget icon;
  final List<TextInputFormatter> inputFormatters;
  final Border border;
  final int maxLines;
  final double height;
  final TextEditingController controller;
  const JdText({
    Key key,
    this.text = "请输入",
    this.password = false,
    this.onChanged,
    this.icon,
    this.inputFormatters,
    this.border = const Border(
      bottom: BorderSide(width: 1, color: Colors.black26),
    ),
    this.maxLines = 1,
    this.height = 100,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      alignment: Alignment.center,
      height: ScreenAdapter.height(this.height),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(border: this.border),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: ScreenAdapter.size(36)),
        obscureText: this.password,
        decoration: InputDecoration(
          icon: this.icon,
          hintText: this.text,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: this.onChanged,
        inputFormatters: this.inputFormatters,
        maxLines: this.maxLines,
      ),
    );
  }
}
