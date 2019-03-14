import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// FutureBuilder
// http://gank.io/api/xiandu/categories

class FutureBuilderPage extends StatefulWidget {
  @override
  FutureBuilderState createState() => FutureBuilderState();
}

class FutureBuilderState extends State<FutureBuilderPage> {
  final _url = 'http://gank.io/api/xiandu/categories';
  FadeTransition r;
  ScaleTransition e;
  Future<BaseBean> _getData() async {
    var response = await http
        .get(Uri.encodeFull(_url), headers: {"Accept": "application/json"});
    BaseBean baseBean = BaseBean.fromJson(jsonDecode(response.body));
    return baseBean;
  }

  Widget _getListView(List<TitleBean> datas) {
    List<ListTile> list = [];
    for (var i = 0; i < datas.length; ++i) {
      list.add(ListTile(
        title: Text('${datas[i].name}'),
        subtitle: Text('${datas[i].en_name}'),
      ));
    }
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
          title: Text('FutureBuilder'),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: FutureBuilder<BaseBean>(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                // 未执行
                return Text("未执行");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 正在执行
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.active) {
                // 连接到一个活跃的操作,不断获取值
                return Text("active");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                // 执行结束
                return _getListView(snapshot.data.results);
              }
            },
          ),
        ),
      ),
    );
  }
}

class BaseBean {
  bool error;
  List<TitleBean> results;

  BaseBean({this.error, this.results});

  factory BaseBean.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    print('长度 = ${list.length}');
    print(list.runtimeType);
    List<TitleBean> mList = list.map((i) => TitleBean.fromJson(i)).toList();
    return BaseBean(
      error: json['error'],
      results: mList,
    );
  }
}

class TitleBean {
  String id;
  String en_name;
  String name;
  int rank;

  TitleBean({this.id, this.en_name, this.name, this.rank});

  factory TitleBean.fromJson(Map<String, dynamic> json) {
    return TitleBean(
        id: json['_id'],
        en_name: json['en_name'],
        name: json['name'],
        rank: json['rank']);
  }
}
