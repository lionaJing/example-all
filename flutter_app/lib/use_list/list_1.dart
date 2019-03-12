import 'package:flutter/material.dart';

// ListView 1
// 使用 ListTile,样式比较固定,不能自定义,相关属性如下
// leading 最左边图标
// trailing 最右边图标
// title 标题
// subtitle 副标题
// isThreeLine 是否三行显示(默认 false)

class ListView1Page extends StatelessWidget {
  Widget _buildListTile(BuildContext context) {
    List<ListTile> list = [];
    for (var i = 0; i < 3; ++i) {
      list.add(ListTile(
        leading: CircleAvatar(child: Text(i.toString())),
        title: Text('title-' + i.toString()),
        subtitle: Text('subtitle'),
      ));
    }
    for (var i = 0; i < 3; ++i) {
      list.add(ListTile(
        leading: CircleAvatar(child: Text(i.toString())),
        title: Text('标题-' + i.toString()),
        subtitle: Text('i am 副标题 i am 副标题 i am 副标题 i am 副标题 i am 副标题 '
            'i am 副标题 i am 副标题 i am 副标题 i am 副标题 '
            'i am 副标题'),
        isThreeLine: true,
      ));
    }
    //没有分割线
//    return ListView(
//      children: list,
//    );
    //有分割线
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: list).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListTile Demo'),
        ),
        body: Container(
          child: _buildListTile(context),
        ),
      ),
    );
  }
}
