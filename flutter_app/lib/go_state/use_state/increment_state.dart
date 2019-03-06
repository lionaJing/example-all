import 'package:flutter/material.dart';

//增加page
class IncrementStatePage extends StatefulWidget {
  final int counter;
  final ValueChanged<void> incrementCounter;

  IncrementStatePage({
    Key key,
    this.counter,
    this.incrementCounter,
  }) : super(key: key);

  @override
  IncrementState createState() => IncrementState();
}

class IncrementState extends State<IncrementStatePage> {
  void _onPressed() {
    widget.incrementCounter(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('增加值 page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击按钮值增加'),
            Text(
              widget.counter.toString(),
            ),
            RaisedButton(
              child: Text('增加'),
              onPressed: _onPressed,
            ),
            RaisedButton(
              child: Text('返回'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
