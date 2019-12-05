import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:ruzhou/entity/user_entity.dart';

class UserInfoModel with ChangeNotifier {
  UserEntity _user;
  UserEntity get user => _user;

  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
