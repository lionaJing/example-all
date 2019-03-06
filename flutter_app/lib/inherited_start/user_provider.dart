import 'package:flutter/material.dart';
import 'package:flutter_app/inherited_start/user.dart';

// InheritedWidget

class UserProvider extends InheritedWidget {
  final User user;

  UserProvider({Key key, User user, @required Widget child})
      : user = user ?? User(name: 'Admin'),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static User of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(UserProvider) as UserProvider).user;

  //更新用户
  void updateUser({name, age, phone, address}) {
//    User(
//        name: name ?? 'Admin',
//        age: int.parse(age ?? '0'),
//        phone: phone ?? 'XXX',
//        address: address ?? 'XX');
  }
}
