import 'package:flutter/material.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/screens/login.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/screens/catalog.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/screens/cart.dart';

//购物车 demo

class CartHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyLoginScreen(),
        '/catalog': (context) => MyCatalog(),
        '/cart': (context) => MyCart(),
      },
    );
  }
}
