import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 1,
            ),
            SizedBox(width: 5),
            Text(
              "加载中...",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
