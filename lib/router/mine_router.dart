import 'package:fluro/fluro.dart';
import 'package:ruzhou/page/find/find_page.dart';
import 'package:ruzhou/page/home/home_page.dart';
import 'package:ruzhou/page/mine/mine_page.dart';
import 'package:ruzhou/router/router_init.dart';

class MineRouter implements IRouterProvider{

  static String minePage = "/mine";

  @override
  void initRouter(Router router) {
    router.define(minePage, handler: Handler(handlerFunc: (_, params) => MinePage()));
  }

}