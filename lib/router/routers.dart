import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/router/router_handlers.dart';

class Routers {
  static String root = "/";
  static String home = "/home";
  static String find = "/find";
  static String mine = "/mine";


  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      print("handler not find");
    });

    router.define(root, handler: ruZhouHandler);
    router.define(find, handler: findHandler);
    router.define(mine, handler: mineHandler);
  }
}
