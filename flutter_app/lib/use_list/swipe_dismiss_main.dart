import 'package:flutter/material.dart';

// 列表 item 拖动效果,依赖 Dismissible 控件
// 看这个开源库 https://github.com/letsar/flutter_slidable

class SwipeDismissPage extends StatefulWidget {
  @override
  SwipeDismissState createState() => SwipeDismissState();
}

class SwipeDismissState extends State<SwipeDismissPage> {
  List<String> list = List.generate(5, (index) => 'Item number $index');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('右滑删除 Demo'),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: _myWidget(context, list),
        ),
      ),
    );
  }

  Widget _myWidget(BuildContext context, List<String> list) {
    var length = list.length;
    List<Dismissible> mList = [];
    for (var i = 0; i < length; ++i) {
      mList.add(
        Dismissible(
          // 注意这里的 key
          key: Key(list[i]),
          // 定义拖动的方向
//          direction: DismissDirection.endToStart,
          // 定义控件消失或回到原始位置的时间
          movementDuration: Duration(seconds: 1),
          // 定义拖到到什么程度才会触发 dismissed 事件
          // 如： 0.1 = 拖动到控件的 10%
          dismissThresholds: {
            DismissDirection.horizontal: 0.3,
            DismissDirection.endToStart: 0.3,
            DismissDirection.startToEnd: 0.3
          },
          // 在操作时给予确认(异步方法),可以弹出对话框
          // 返回 false 不会触发 dismissed
          confirmDismiss: (direction) {
            return showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('提示'),
                  content: Text('确定操作?'),
                  actions: <Widget>[
                    MaterialButton(
                      padding: EdgeInsets.all(8.0),
                      child: Text("确定"),
                      onPressed: () {
                        Navigator.pop(context,true);
                      },
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(8.0),
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.pop(context,false);
                      },
                    )
                  ],
                );
              },
            );
//            return Future<bool>(() {});
          },
          // 向下或向右拖动子项时才会显示(控件左侧)
          background: Container(
            color: Colors.lightGreen,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete),
            ),
          ),
          // 向上或向左拖动时会出现(控件右侧)
          secondaryBackground: Container(
            color: Colors.purple,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.ac_unit),
            ),
          ),
          child: ListTile(
            title: Text('${list[i]}'),
          ),
          onDismissed: (direction) {
            setState(() {
              list.removeAt(i);
            });
          },
        ),
      );
    }
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: mList).toList(),
    );
  }
}
