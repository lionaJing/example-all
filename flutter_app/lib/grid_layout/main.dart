import 'package:flutter/material.dart';
import 'package:flutter_app/grid_layout/grid_view.dart';

/// 网格布局

class GridPage extends StatelessWidget {
  final MyGridView myGridView = new MyGridView();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text("GridView Example"),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: myGridView.build(),
      ),
    );
  }
}
