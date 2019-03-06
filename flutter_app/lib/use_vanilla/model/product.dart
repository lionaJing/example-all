import 'dart:ui' show Color;

class Product {
  // 商品唯一标识
  final int id;

  //商品名(用于展示)
  final String name;
  final Color color;

  const Product(this.id, this.name, this.color);

  @override
  int get hashCode => this.id;

  @override
  bool operator ==(other) => (other) is Product && other.hashCode == hashCode;

  @override
  String toString() => "$name (id=$id)";
}
