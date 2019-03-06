import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/models/cart_model.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/catalog');
          },
        ),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Container(height: 4, color: Colors.black),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

//添加到购物车的商品列表
class _CartList extends StatelessWidget {
  const _CartList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        return ListView(
          children: model.items
              .map((item) => Text(
                    '· ${item.name}',
                    style: Theme.of(context).textTheme.title,
                  ))
              .toList(),
        );
      },
    );
  }
}

//费用总计
class _CartTotal extends StatelessWidget {
  const _CartTotal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                return Text(
                  '\$${model.totalPrice}',
                  style: Theme.of(context)
                      .textTheme
                      .display4
                      .copyWith(fontSize: 48),
                );
              },
            ),
            SizedBox(width: 24),
            FlatButton(
                onPressed: () {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('购买成功')));
                },
                color: Colors.white,
                child: Text('购买'))
          ],
        ),
      ),
    );
  }
}
