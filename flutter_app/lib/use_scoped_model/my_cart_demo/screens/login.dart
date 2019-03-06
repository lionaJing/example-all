import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/use_scoped_model/my_cart_demo/models/cart_model.dart';

//登录页面
class MyLoginScreen extends StatelessWidget {
  //点击登录
  void onLoginSubmit(BuildContext context) {
    // 这里的UI不依赖于模型的状态。 我们只需要模型就可以调用方法。
    // 因此，我们使用ScopedModel.of而不是ScopedModelDescendant小部件。
    var cart = ScopedModel.of<CartModel>(context);

    // Now that we have reference to the cart, we can clear it, for example.
    cart.clear();
    Navigator.pushReplacementNamed(context, '/catalog');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome'),
              SizedBox(height: 24),
              _LoginTextField(hintText: 'Login'),
              SizedBox(height: 12),
              _LoginTextField(hintText: 'Password', obscureText: true),
              SizedBox(height: 24),
              FlatButton(
                onPressed: () => onLoginSubmit(context),
                color: Colors.yellow,
                child: Text('登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Convenience widget for the login text fields.
class _LoginTextField extends StatelessWidget {
  final String hintText;

  final bool obscureText;

  _LoginTextField({
    Key key,
    @required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.black12,
      ),
      obscureText: obscureText, //是否隐藏输入(密码输入隐藏)
    );
  }
}
