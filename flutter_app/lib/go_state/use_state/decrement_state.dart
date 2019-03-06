import 'package:flutter/material.dart';
import 'package:flutter_app/go_state/use_state/increment_state.dart';

//减小page
class DecrementStatePage extends StatefulWidget {
  final int counter;
  final ValueChanged<void> decrementCounter;
  final ValueChanged<void> incrementCounter;

  DecrementStatePage({
    Key key,
    this.counter,
    this.decrementCounter,
    this.incrementCounter,
  }) : super(key: key);

  @override
  DecrementState createState() => DecrementState();
}

class DecrementState extends State<DecrementStatePage> {
  void _onPressed() {
    widget.decrementCounter(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('减小值 page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击按钮值减少'),
            Text(
              widget.counter.toString(),
            ),
            RaisedButton(
              child: Text('减少'),
              onPressed: _onPressed,
            ),
            RaisedButton(
              child: Text('下一页面'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IncrementStatePage(
                            counter: widget.counter,
                            incrementCounter: widget.incrementCounter,
                          ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
