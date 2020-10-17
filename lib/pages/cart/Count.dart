import 'package:flutter/material.dart';
import 'package:flutter_myshop/provider/Counter.dart';
import 'package:provider/provider.dart';

class CountWidget extends StatelessWidget {
  const CountWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${context.watch<Counter>().count}',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
