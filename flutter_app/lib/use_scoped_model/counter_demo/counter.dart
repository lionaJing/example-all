import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Flutter 状态管理 scoped_model 库 Demo
// https://github.com/brianegan/scoped_model

class CounterPage extends StatelessWidget {
  final CounterModel model;

  const CounterPage({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //在应用的顶部创建一个 ScopedModel 组件,它将给 app 所有的 children 通过
    // ScopedModelDescendant 提供 CounterModel
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('scoped_model Counter Demo'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: CounterHome(),
        ),
      ),
    );
  }
}

//Note: It must extend from Model.
//包含操作的方法及数值
class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class CounterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击按钮数值增加:'),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                return Text(
                  model.counter.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            ScopedModelDescendant<CounterModel>(
              rebuildOnChange: true,
              builder: (context, child, model) {
                return RaisedButton(
                  child: Text('to add'),
                  onPressed: model.increment,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
