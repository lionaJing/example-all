import 'package:flutter_app/use_vanilla/model/product.dart';

class CartItem {
  final int count;
  final Product product;

  const CartItem(this.count, this.product);

  @override
  String toString() => "${product.name} ✕ $count";
}
