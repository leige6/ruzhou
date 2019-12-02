import 'package:flutter/material.dart' show ChangeNotifier;

class UserInfoModel with ChangeNotifier {
  String _name = "用户名";
  String testData = "测试数据"; //尽量私有变量定义
  String get name => _name;

  void setName(name) {
    _name = name;
    notifyListeners(); //通知更新数据
  }

  @override
  void dispose() {
    super.dispose();
  }
}
