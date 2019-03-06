import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// shares preferences 数据持久存储测试

class SpPage extends StatefulWidget {
  @override
  SpState createState() => new SpState();
}

class SpState extends State<SpPage> {
  var nameOfApp = "Persist Key Value";
  var counter = 0;
  var key = "counter";

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.get(key) ?? 0);
    });
  }

  // 增加值
  _onIncrementHit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.get(key) ?? 0) + 1;
    });
    prefs.setInt(key, counter);
  }

  // 减小值
  _onDecrementHit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.get(key) ?? 0) - 1;
    });
    prefs.setInt(key, counter);
  }

  // 创建 dialog
  _createdDialog(BuildContext context, String message) {
    return new AlertDialog(
      content: new Text(message),
      title: new Text('提示'),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text("确定"),
          padding: EdgeInsets.all(8.0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text('Shares Preferences'),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  '$counter',
                  textScaleFactor: 5.0,
                ),
                new Padding(padding: new EdgeInsets.all(8.0)),
                new RaisedButton(
                  child: new Text('增加值'),
                  onPressed: () {
                    _onIncrementHit();
                  },
                ),
                new Padding(padding: new EdgeInsets.all(8.0)),
                new RaisedButton(
                  child: new Text('减小值'),
                  onPressed: () {
                    _onDecrementHit();
                  },
                ),
                new Padding(padding: new EdgeInsets.all(8.0)),
                new RaisedButton(
                    child: new Text('dialog弹出当前值'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              _createdDialog(context, counter.toString()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
