import 'package:flutter/material.dart';
import 'package:flutter_app/use_vanilla/model/cart.dart';
import 'package:flutter_app/use_vanilla/model/catalog.dart';
import 'package:flutter_app/use_vanilla/model/product.dart';
import 'package:flutter_app/use_vanilla/widgets/cart_button.dart';
import 'package:flutter_app/use_vanilla/widgets/cart_page.dart';
import 'package:flutter_app/use_vanilla/widgets/product_square.dart';
import 'package:flutter_app/use_vanilla/widgets/theme.dart';

//使用 vanilla 管理状态
//主页-商品列表

class VanillaMainPage extends StatelessWidget {
  // cart 作为共享数据,这样做是不好的
  final cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanilla',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(cart: cart),
      routes: <String, WidgetBuilder>{
        // 注意这里的 cart
        CartPage.routeName: (context) => CartPage(cart),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Cart cart;

  MyHomePage({
    Key key,
    @required this.cart,
  }) : super(key: key);

  @override
  createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // 点击商品增加到购物车(每次增加一个)
  // 这里还有另外一种实现 通过 ValueNotifier,监听 add value 变化
  _updateCart(Product product) {
    setState(() => widget.cart.add(product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vanilla'),
        actions: <Widget>[
          CartButton(
            //顶部购物车上的数量
            itemCount: widget.cart.itemCount,
            onPressed: () {
              //点击跳转到购物车
              Navigator.of(context).pushNamed(CartPage.routeName);
            },
          )
        ],
      ),
      body: ProductGrid(
        cart: widget.cart,
        updateProduct: _updateCart,
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final Cart cart;
  final Function(Product) updateProduct;

  ProductGrid({
    Key key,
    @required this.cart,
    @required this.updateProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: catalog.products.map((product) {
        return ProductSquare(
          product: product,
          onTap: () => updateProduct(product),
        );
      }).toList(),
    );
  }
}
