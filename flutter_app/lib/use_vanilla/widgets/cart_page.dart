import 'package:flutter/material.dart';
import 'package:flutter_app/use_vanilla/model/cart.dart';
import 'package:flutter_app/use_vanilla/model/cart_item.dart';
import 'package:flutter_app/use_vanilla/utils/is_dark.dart';

//购物车页面

class CartPage extends StatelessWidget {
  CartPage(this.cart);
  final Cart cart;

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: cart.items.isEmpty
          ? Center(
          child: Text('空的', style: Theme.of(context).textTheme.display1))
          : ListView(
          children:
          cart.items.map((item) => ItemTile(item: item)).toList()),
    );
  }
}

class ItemTile extends StatelessWidget {
  ItemTile({this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: isDark(item.product.color) ? Colors.white : Colors.black);

    return Container(
      color: item.product.color,
      child: ListTile(
        title: Text(
          item.product.name,
          style: textStyle,
        ),
        trailing: CircleAvatar(
            backgroundColor: const Color(0x33FFFFFF),
            child: Text(item.count.toString(), style: textStyle)),
      ),
    );
  }
}