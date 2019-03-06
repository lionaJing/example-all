/// 关于序列化：
/// 小项目手动序列化可用 Dart 内置的 ‘dart:convert’,里面提供两个方法
///   jsonDecode(string) 返回 Map<String, dynamic>
///   jsonEncode(obj)
/// 但是由于 jsonDecode 返回的是 dynamic 类型,当 JSON 格式出错时,容易异常,所以可以在
/// 模板中序列化 json
///   * .fromJson(Map<String, dynamic>) 构造函数,构造实例对象
///   * toJson() 将实例转化为 map
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
