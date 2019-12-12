import 'package:fluro/fluro.dart';
import 'package:ruzhou/page/mine/mine_page.dart';
import 'package:ruzhou/page/mine/user_share_page.dart';
import 'package:ruzhou/router/router_init.dart';


class MineRouter implements IRouterProvider{

  static String minePage = "/mine";
  static String userSharePage = "/mine/share";

  @override
  void initRouter(Router router) {
    router.define(minePage, handler: Handler(handlerFunc: (_, params) => MinePage()));
    router.define(userSharePage, handler: Handler(handlerFunc: (_, params) => UserSharePage()));
  }

}