import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:ruzhou/utils/utils.dart';

class LoginProvider with ChangeNotifier {
  String _randomStr;
  String get randomStr => _randomStr;

  void updateRandomStr() {
    _randomStr=null;
    _randomStr =Utils.generateUUID();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
