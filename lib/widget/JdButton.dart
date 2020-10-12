import 'package:flutter/material.dart';
import 'package:flutter_myshop/services/ScreenAdaper.dart';

class JdButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function cb;
  const JdButton({Key key, this.color, this.text, this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return InkWell(
      onTap: this.cb,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: ScreenAdapter.height(100),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
