import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:ruzhou/widgets/app_bar.dart';
import 'package:ruzhou/widgets/html_web_view.dart';
import 'package:flutter/services.dart' show rootBundle;

class ServiceAgreePage extends StatefulWidget {
  @override
  _ServiceAgreePageState createState() => _ServiceAgreePageState();
}


class _ServiceAgreePageState extends State<ServiceAgreePage> {

  String _url = 'assets/html/loginAgr.html';


  @override
  void initState() {
    super.initState();
    ///用_futureBuilderFuture来保存_gerData()的结果，以避免不必要的ui重绘:相关blog地址：https://blog.csdn.net/u011272795/article/details/83010974
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      //监听物理按键返回
      onWillPop: (){
        NavigatorUtils.goBack(context);
      },
      child: HtmlWebView(
        type: 0,
        webUrl: this._url,
        title: '服务条款',
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}