import 'package:flutter/material.dart';

// CustomScrollView 测试
// 场景： 当前页面同时存在 ListView GridView,需求是让他们同时滑动,CustomScrollView
// 的作用就是将当前页面连接为一个整体,保证统一滑动
// CustomScrollView 要求其子 Widget 必须是 Sliver 家族的
//
// SliverList 与 SliverFixedExtentList 区别？
// SliverList 无法确定其范围(自己推算滚偏移,从而对其子节点进行布局)
// SliverFixedExtentList 可以确定其固定范围
//
// Sliver家族的组件与 其他可滚动Widget区别？
// 可滚动Widget都直接或间接包含一个Scrollable widget
// Sliver不会包含Scrollable Widget，不包含滚动交互模型

class SliversPage extends StatefulWidget {
  @override
  SliversState createState() => SliversState();
}

class SliversState extends State<SliversPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CustomScrollView Demo'),
        ),
        body: CustomScrollView(
          // 该值用于控制 CustomScrollView 相对于父控件的偏移位置(默认值 0)
          // 取值范围(0 ~ 1)
          anchor: 0,
          // 设置缓存区域(在可见区域之前和之后的区域)
          // 在用户滚动时变为可见区域,该区域即使在屏幕上未显示依然会被布局
          cacheExtent: 0,
          slivers: <Widget>[
            SliverFixedExtentList(
              //强制设置 item 的宽度(或高度,根据滑动方向判断)
              //这样做可以减少对列表高度的计算
              itemExtent: 50,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 5.0,
                //设置item的宽高比
                childAspectRatio: 3.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
