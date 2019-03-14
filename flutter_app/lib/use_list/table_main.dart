import 'package:flutter/material.dart';

//表格控件

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('表格 Demo'),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Table(
            //表格的对齐方式
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            //水平列的相对宽
            // FractionColumnWidth
            // FlexColumnWidth
            // IntrinsicColumnWidth
            // FixedColumnWidth
            defaultColumnWidth: FlexColumnWidth(1.0),
            columnWidths: {1: FractionColumnWidth(.25)},
            // 增加边框 TableBorder.all()
            border: TableBorder(
                bottom: BorderSide(color: Colors.blueGrey, width: 5)),
            children: [
              TableRow(children: [
                Container(
                  color: Colors.red,
                  height: 50.0,
                ),
                Container(color: Colors.purple, height: 50.0),
                Container(color: Colors.green, height: 80.0),
                Container(color: Colors.amberAccent, height: 50.0),
              ]),
              TableRow(children: [
                Container(
                  color: Colors.black26,
                  height: 50.0,
                ),
                Container(color: Colors.blueAccent, height: 90.0),
                Container(color: Colors.greenAccent, height: 50.0),
                Container(color: Colors.teal, height: 100.0),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
