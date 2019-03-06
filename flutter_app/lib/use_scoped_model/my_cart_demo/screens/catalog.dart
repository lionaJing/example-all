import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/models/cart_model.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/models/src/item.dart';

//商品列表
class MyCatalog extends StatelessWidget {
  MyCatalog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('商品列表'),
      floating: true,
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart')),
      ],
    );
  }
}

class MyListItem extends StatelessWidget {
  final int index;
  final Item item;

  MyListItem(
    this.index, {
    Key key,
  })  : item = Item(index),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: Theme.of(context).textTheme.title),
            ),
            SizedBox(width: 24),
            _AddButton(
              item: item,
            ),
          ],
        ),
      ),
    );
  }
}

//加入购物车按钮
class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) {
        return FlatButton(
          onPressed: model.items.contains(item) ? null : () => model.add(item),
          child: model.items.contains(item) ? Icon(Icons.check) : Text('增加'),
        );
      },
    );
  }
}
