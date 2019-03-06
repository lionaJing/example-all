import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

//Flutter 状态管理 scoped_model 库 Demo 测试异步调用

class CounterSyncPage extends StatelessWidget {
  final AbstractModel model;

  const CounterSyncPage({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AbstractModel>(
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
          body: CounterSyncHome(),
        ),
      ),
    );
  }
}

abstract class AbstractModel extends Model {
  int get counter;

  void increment();
}

class CounterSyncModel extends AbstractModel {
  int _counter = 10;

  int get counter => _counter;

  void increment() async {
    _counter++;
    //模拟 Http 请求
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }
}

class CounterSyncHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('点击按钮延迟2s后数值变化'),
          ScopedModelDescendant<AbstractModel>(
            builder: (context, child, model) {
              return Text(
                model.counter.toString(),
                style: Theme.of(context).textTheme.display1,
              );
            },
          ),
          ScopedModelDescendant<AbstractModel>(
            builder: (context, child, model) {
              return RaisedButton(
                child: Text('to sync add'),
                onPressed: model.increment,
              );
            },
          ),
        ],
      ),
    );
  }
}
