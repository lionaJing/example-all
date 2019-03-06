import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_start/user_provider.dart';

//编辑用户
//获取输入框的值必须设置组件为 StatefulWidget
// 输入框介绍 https://blog.csdn.net/u011272795/article/details/82528432

class EditUserPage extends StatefulWidget {
  @override
  EditUserState createState() => EditUserState();
}

class EditUserState extends State<EditUserPage> {
  final TextEditingController nameCr = TextEditingController();
  final TextEditingController ageCr = TextEditingController();
  final TextEditingController phoneCr = TextEditingController();
  final TextEditingController addressCr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('编辑用户'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameCr,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  icon: Icon(Icons.person),
                  labelText: '姓名',
                ),
              ),
              TextField(
                controller: ageCr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  icon: Icon(Icons.adjust),
                  labelText: '年龄',
                ),
              ),
              TextField(
                controller: phoneCr,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  icon: Icon(Icons.phone),
                  labelText: '电话',
                ),
              ),
              TextField(
                controller: addressCr,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  icon: Icon(Icons.add_location),
                  labelText: '地址',
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            debugPrint(nameCr.text);
            debugPrint(ageCr.text);
            debugPrint(phoneCr.text);
            debugPrint(addressCr.text);

            user.name = nameCr.text;
//            assert(ageCr.text is String);
//            assert(ageCr.text is int);
            user.age = 12; //int.parse(ageCr.text); //ageCr.text
            user.phone = phoneCr.text;
            user.address = addressCr.text;
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
