import 'package:flutter/material.dart';
import 'package:flutter_app/drawer_nav/screens/home.dart';
import 'package:flutter_app/drawer_nav/screens/account.dart';
import 'package:flutter_app/drawer_nav/screens/setting.dart';

//导航抽屉效果

class NavigationDrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomeScreen(),
      routes: <String, WidgetBuilder>{
        // define the routes
        SettingsScreen.routeName: (BuildContext context) =>
            new SettingsScreen(),
        AccountScreen.routeName: (BuildContext context) => new AccountScreen(),
      },
    );
  }
}
