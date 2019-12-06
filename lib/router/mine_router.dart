import 'package:fluro/fluro.dart';
import 'package:ruzhou/page/find/find_page.dart';
import 'package:ruzhou/page/home/home_page.dart';
import 'package:ruzhou/page/mine/mine_page.dart';
import 'package:ruzhou/page/mine/service_agree_page.dart';
import 'package:ruzhou/router/router_init.dart';
import 'package:ruzhou/widgets/html_web_view.dart';

class MineRouter implements IRouterProvider{

  static String minePage = "/mine";
  static String serviceAgeree = "/mine/serviceAgeree";

  @override
  void initRouter(Router router) {
    router.define(minePage, handler: Handler(handlerFunc: (_, params) => MinePage()));
    router.define(serviceAgeree, handler: Handler(handlerFunc: (_, params) => ServiceAgreePage()));
  }

}