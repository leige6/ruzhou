import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/page/find/find_page.dart';
import 'package:ruzhou/page/mine/mine_page.dart';
import 'package:ruzhou/page/ruzhou.dart';

var ruZhouHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RuZhouMainView();
});

var findHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return FindPage();
    });

var mineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return MinePage();
    });


