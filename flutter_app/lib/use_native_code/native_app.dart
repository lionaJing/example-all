import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//flutter 与 Android原生交互

class NativeCodePage extends StatefulWidget {
  @override
  NativeCodeState createState() => NativeCodeState();
}

class NativeCodeState extends State<NativeCodePage> {
  //在这里构造通道 MethodChannel,并指定唯一的通道标识
  //客户端与服务端将依赖此通道进行交互
  static const methodChannel = const MethodChannel('com.lemon.flutter/message');

  static const eventChannel = EventChannel('com.lemon.flutter/charging');

  String _message = 'unknown...';
  String _message1 = 'unknown...';
  String _chargingStatus = 'unknown...';

  //异步方法，调用无参原生方法
  Future<void> _getMessage() async {
    String message;
    try {
      final String result = await methodChannel.invokeMethod('getMessage');
      message = '原生消息:$result';
    } on PlatformException {
      message = '接收消息失败';
    }

    setState(() {
      _message = message;
    });
  }

  //异步方法，调用有参原生方法
  Future<void> _getMessage1() async {
    String message;
    try {
      final String result = await methodChannel
          .invokeMethod('getMessage1', {'name': 'Jack', 'age': 18});
      message = '原生消息:$result';
    } on PlatformException {
      message = '接收消息失败';
    }

    setState(() {
      _message1 = message;
    });
  }

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object event) {
    setState(() {
      _chargingStatus = '$event';
    });
  }

  void _onError(Object error) {
    setState(() {
      _chargingStatus = 'unknown.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('与原生交互'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Text(
                  '初始化时Native调用Flutter:',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                '$_chargingStatus',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                color: Colors.lightGreen,
                height: 4,
                margin: EdgeInsets.all(16),
              ),
              Text(
                'Flutter调Native-无参',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Text('$_message')),
                  RaisedButton(
                    onPressed: _getMessage,
                    child: Text('点击'),
                  ),
                ],
              ),
              Text(
                'Flutter调Native-有参',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Text('$_message1')),
                  RaisedButton(
                    onPressed: _getMessage1,
                    child: Text('点击'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
