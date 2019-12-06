import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/page/home/home_page.dart';
import 'package:ruzhou/page/ruzhou.dart';
import 'package:ruzhou/router/router_init.dart';
import 'package:ruzhou/widgets/html_web_view.dart';
import 'package:ruzhou/widgets/webview_page.dart';

import '404.dart';
import 'find_router.dart';
import 'fluro_convert_util.dart';
import 'home_router.dart';
import 'mine_router.dart';

class Routers {
  static String root = "/";
  static String webViewPage = "/webview";
  static List<IRouterProvider> _listRouter = [];
  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          debugPrint("未找到目标页");
          return WidgetNotFound();
        });

    router.define(root, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => RuZhouMainView()));
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params){
      String title = params['title']?.first;
      String url = params['webUrl']?.first;
      String type = params['type']?.first;
      return HtmlWebView(title: FluroConvertUtils.fluroCnParamsDecode(title), webUrl: Uri.decodeComponent(url),type: FluroConvertUtils.string2int(type),);
    }));
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(HomeRouter());
    _listRouter.add(FindRouter());
    _listRouter.add(MineRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }

}
