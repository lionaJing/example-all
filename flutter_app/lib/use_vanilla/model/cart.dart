import 'dart:collection';
import 'dart:math';
import 'package:flutter_app/use_vanilla/model/cart_item.dart';
import 'package:flutter_app/use_vanilla/model/product.dart';

class Cart {
  final List<CartItem> _items = <CartItem>[];

  Cart();

  Cart.clone(Cart cart) {
    _items.addAll(cart._items);
  }

  // 用给定产品的样品填充购物车。
  Cart.sample(Iterable<Product> products) {
    _items.addAll(products.take(3).map((product) => CartItem(1, product)));
  }

  /// 购物车中商品的总数，包括同一商品的重复商品
  int get itemCount => _items.fold(0, (sum, el) => sum + el.count);

  // 这是购物车的当前状态。
  // 购物车商品与购买商品的顺序相同
  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void add(Product product, [int count = 1]) {
    _updateCount(product, count);
  }

  void remove(Product product, [int count = 1]) {
    _updateCount(product, -count);
  }

  void _updateCount(Product product, int difference) {
    if (difference == 0) return;
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (product == item.product) {
        final newCount = item.count + difference;
        if (newCount <= 0) {
          _items.removeAt(i);
          return;
        }
        _items[i] = CartItem(newCount, item.product);
        return;
      }
    }
    if (difference < 0) return;
    _items.add(CartItem(max(difference, 0), product));
  }

  @override
  String toString() => "$items";
}
