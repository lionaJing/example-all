import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/drop_down.dart';
import 'package:flutter_app/grid_layout/main.dart';
import 'package:flutter_app/routes/route_home.dart';
import 'package:flutter_app/json/load_json.dart';
import 'package:flutter_app/shared_preferences/value.dart';
import 'package:flutter_app/bottom_nav/navigator_tab.dart';
import 'package:flutter_app/use_http/http_get.dart';
import 'package:flutter_app/stepper/use_stepper.dart';
import 'package:flutter_app/fonts/use_fonts.dart';
import 'package:flutter_app/drawer_nav/navgiation_drawer.dart';
import 'package:flutter_app/use_expansion/expansion.dart';
import 'package:flutter_app/use_scoped_model/counter_demo/counter.dart';
import 'package:flutter_app/use_scoped_model/counter_demo/counter_sync.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/models/cart_model.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/cart_home.dart';
import 'package:flutter_app/go_state/use_state/home_state.dart';
import 'package:flutter_app/use_vanilla/vanilla_main.dart';
import 'package:flutter_app/inherited_start/inherited_main.dart';
import 'package:flutter_app/use_animations/easing_animation.dart';
import 'package:flutter_app/use_animations/inkwell_hero.dart';
import 'package:flutter_app/use_animations/masking.dart';
import 'package:flutter_app/use_animations/offset_delay.dart';
import 'package:flutter_app/use_animations/parenting.dart';

/// 应用入口,展示为一个列表
void main() => runApp(MyApp());

///void main() {
///  runApp(MyApp());
///}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 取消 debug 小横幅(默认 true)
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Welcome to Flutter')),
        body: Center(
          child: ListExamplePage(),
        ),
      ),
    );
  }
}

/// 测试列表页面
class ListExamplePage extends StatelessWidget {
  _buildList() {
    return <UseBean>[
      const UseBean("下拉框", "下拉按钮-DropDown Button"),
      const UseBean("网格布局", "grid_layout"),
      const UseBean("路由", "route"),
      const UseBean("JSON", "dart:convert"),
      const UseBean("shared Preferences", "数据持久化(sp)"),
      const UseBean("底部导航", "Navigation bottom"),
      const UseBean("HTTP-GET", "http 网络请求"),
      const UseBean("stepper", "进度小组件"),
      const UseBean("customer-fonts", "自定义字体"),
      const UseBean("Navigation-Drawer", "侧边栏拉出来的导航面板"),
      const UseBean("ExpansionTiles", "两级或多级列表"),
      const UseBean("计数器", "通过 setState 执行状态管理"),
      const UseBean("Vanilla", "状态管理,实现原理和上面的计数器相同"),
      const UseBean("InheritedWidget", "BLoC架构初探+StreamBuilder"),
      const UseBean("Counter", "scoped_model 状态管理 demo"),
      const UseBean("Counter Sync", "scoped_model 状态管理 异步模拟 HTPP"),
      const UseBean("MyCart", "scoped_model 状态管理 demo-购物车"),
      const UseBean("EasingAnimation", "缓动动画"),
      const UseBean("InkWell-Fero", "缓动动画"),
      const UseBean("Masking-Animation", "动画..."),
      const UseBean('OffsetDelayAnimation', '动画...'),
      const UseBean('ParentingAnimation', '动画...')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new ContactsList(_buildList()));
  }
}

/// List 组件
class ContactsList extends StatelessWidget {
  final List<UseBean> _useBean;

  ContactsList(this._useBean);

  @override
  Widget build(BuildContext context) {
    var _buildContactsList =
        ListTile.divideTiles(context: context, tiles: _getListData(context))
            .toList();

    return new ListView(
      /// EdgeInsets 类似于 padding,
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      children: _buildContactsList,
    );
  }

  _getListData(BuildContext context) {
    return _useBean
        .map((use) => new ListTile(
              leading: new CircleAvatar(child: new Text(use.title[0])),
              title: new Text(use.title),
              subtitle: new Text(use.subTitle),
              onTap: () {
                ///Fluttertoast.showToast(msg: use.title,toastLength: Toast.LENGTH_SHORT);
//                final snackBar = new SnackBar(
//                  content: new Text(use.title),
//                  duration: new Duration(milliseconds: 2000),
//                  action: new SnackBarAction(label: "动作", onPressed: () {}),
//                );
//                Scaffold.of(context).showSnackBar(snackBar);
                _toOpenOtherPage(use, context);
              },
            ))
        .toList();
  }

  void _toOpenOtherPage(UseBean useBean, BuildContext context) {
    switch (useBean.title) {
      case '下拉框':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DropDownPage()));
        break;
      case '网格布局':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GridPage()));
        break;
      case '路由':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RouteHomePage()));
        break;
      case 'JSON':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => JsonPage()));
        break;
      case 'shared Preferences':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SpPage()));
        break;
      case '底部导航':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NavigatorTabBottomHomePage()));
        break;
      case 'HTTP-GET':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHttpGetPage()));
        break;
      case 'stepper':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StepperPage()));
        break;
      case 'customer-fonts':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomFontsPage()));
        break;
      case 'Navigation-Drawer':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationDrawerPage()));
        break;
      case 'ExpansionTiles':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ExpansionPage()));
        break;
      case '计数器':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StateHomePage()));
        break;
      case 'Counter':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CounterPage(model: CounterModel())));
        break;
      case 'Counter Sync':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CounterSyncPage(model: CounterSyncModel())));
        break;
      case 'MyCart':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScopedModel<CartModel>(
                  model: CartModel(),
                  child: CartHomePage(),
                ),
          ),
        );
        break;
      case 'Vanilla':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VanillaMainPage()));
        break;
      case 'InheritedWidget':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InheritedPage()));
        break;
      case 'EasingAnimation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EasingAnimationPage()));
        break;
      case 'InkWell-Fero':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InkWellPage()));
        break;
      case 'Masking-Animation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MaskingAnimationPage()));
        break;
      case 'OffsetDelayAnimation':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OffsetDelayAnimationWidget()));
        break;
      case 'ParentingAnimation':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ParentingAnimationWidget()));
        break;
      default:
        Fluttertoast.showToast(msg: "null", toastLength: Toast.LENGTH_SHORT);
        break;
    }
  }
}

/// List-item
//class ContactListItem extends StatelessWidget {
//  final UseBean _useBean;
//  final List<UseBean> _listUseBean;
//
////  ContactListItem(this._useBean);
//  ContactListItem(this._listUseBean);
//
//  @override
//  Widget build(BuildContext context) {
//    ListTile.divideTiles(tiles: []);
//    return new ListTile(
//      /// 最左侧的头部
//      leading: new CircleAvatar(child: new Text(_useBean.title[0])),
//      title: new Text(_useBean.title),
//      subtitle: new Text(_useBean.subTitle),
//      /// 最右侧的图标 trailing
//    );
//  }
//}

/// 实体类
class UseBean {
  final String title;
  final String subTitle;

  const UseBean(this.title, this.subTitle);
}

/// 记录
/// 1. Container: 窗口小部件类,允许您自定义其子窗口小部件。如果要添加填充，边距，边框
/// 或背景颜色，请使用Container来命名其某些功能
/// 2. 区分 visible widget(可视部件) 和 layout widget(布局部件)
/// 3. All layout widgets have either of the following:
///   * A child property if they take a single child
///   – for example, Center or Container
///   * A children property if they take a list of widgets
///   – for example, Row, Column, ListView, or Stack
/// 4. StatelessWidget 无状态小部件,属性值不可变(为 final)
///    StatefulWidget  有状态窗口小部件
///    窗口小部件的状态存储在 State 对象中
