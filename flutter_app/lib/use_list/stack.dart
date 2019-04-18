import 'package:flutter/material.dart';
//堆叠布局

class StackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('堆叠布局'),
      ),
      body: Container(
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.grey,
              child: Text('A'),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.lime,
                child: Text('B'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
