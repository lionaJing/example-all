import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_start/edit_user.dart';
import 'package:flutter_app/inherited_start/user_provider.dart';

// inheritedWidget 测试(注意其遗传性质即可)
// 如果加上 StreamBuilder 就会一定程度舍弃 StatefulWidget,全部为 StatelessWidget
// (当然必要的地方还是要引入 StatefulWidget,比如需要获取输入框的值)

class InheritedPage extends StatefulWidget {
  @override
  ShowUserPageState createState() => ShowUserPageState();
}

class ShowUserPageState extends State<InheritedPage> {
  int _count = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    //注意此处
    final user = UserProvider.of(context);
    return UserProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('${user.name}信息'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    Positioned(
                        top: -8.0,
                        right: -3.0,
                        child: StreamBuilder<int>(
                          stream: _streamController.stream,
                          initialData: _count,
                          builder: (context, snapshot) => Text(
                                snapshot.data.toString(),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        )),
                  ],
                ),
                onPressed: () => {},
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('姓名:${user.name}'),
                Text('年龄:${user.age}'),
                Text('电话:${user.phone}'),
                Text('地址:${user.address}'),
                SizedBox(height: 50),
                RaisedButton(
                  child: Text("点击测试StreamBuilder"),
                  onPressed: () {
                    _streamController.sink.add(++_count);
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              //点击编辑跳转到编辑 page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditUserPage()));
            },
          ),
        ),
      ),
    );
  }
}
