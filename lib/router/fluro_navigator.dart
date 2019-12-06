import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'fluro_convert_util.dart';
import 'routers.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {
  
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.cupertino);
  }

  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.cupertino).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }
  
  /// 跳到WebView页
  static goWebViewPage(BuildContext context, String title, String webUrl,String type){
    //fluro 不支持传中文,需转换

    push(context, '${Routers.webViewPage}?title=${Uri.encodeComponent(FluroConvertUtils.fluroCnParamsEncode(title))}&webUrl=${Uri.encodeComponent(webUrl)}&type=${type}');
  }
}
