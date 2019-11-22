import 'package:fluro/fluro.dart';
import 'package:ruzhou/page/home/home_page.dart';
import 'package:ruzhou/router/router_init.dart';

class HomeRouter implements IRouterProvider{

  static String homePage = "/home";

  @override
  void initRouter(Router router) {
    router.define(homePage, handler: Handler(handlerFunc: (_, params) => HomePage()));
  }

}