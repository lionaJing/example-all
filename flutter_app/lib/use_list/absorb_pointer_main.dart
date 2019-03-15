import 'package:flutter/material.dart';

// 当在复杂布局的情况下需要控制子控件的点击触摸事件时,该控件可以方便的进行事件的
// 拦截处理

class AbsorbPointerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('AbsorbPointer'),
        ),
        body: AbsorbPointer(
          // 吸收属性,用于打开关闭 AbsorbPointer 的触摸事件拦截
          absorbing: false,
          // 编译语义树时是否忽略此渲染对象的语义,如果为 null,则默认为[absorbing]的值
          ignoringSemantics: true,
          child: _myContentWidget(context),
        ),
      ),
    );
  }

  Widget _myContentWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('按钮1'),
              onPressed: () {},
            ),
            Padding(padding: EdgeInsets.all(16)),
            RaisedButton(
              child: Text('按钮2'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
