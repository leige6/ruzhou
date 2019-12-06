
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'load_image.dart';


class HtmlWebView extends StatefulWidget {

  int type;//0:本地页面；1：http页面
  String webUrl;
  String title;
  HtmlWebView({Key key,@required this.type=0, this.webUrl, @required this.title}) : super(key: key);
  @override
  _HtmlWebViewState createState() => _HtmlWebViewState();
}


class _HtmlWebViewState extends State<HtmlWebView> {


  String _url="";

  Widget webWidget;
  InAppWebViewController webView;
  double lineProgress = 0.0;

  @override
  void initState() {
    super.initState();
    ///用_futureBuilderFuture来保存_gerData()的结果，以避免不必要的ui重绘:相关blog地址：https://blog.csdn.net/u011272795/article/details/83010974
    _loadHtmlFromAssets();
  }


  void _loadHtmlFromAssets() async {
    String res = await rootBundle.loadString(widget.webUrl);
    setState(() {
      _url=res;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.type==0){
      webWidget = _url.isNotEmpty?new InAppWebView(
          initialData: InAppWebViewInitialData(_url),
          initialHeaders: {},
          initialOptions: {},
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            print("started -------------- $url");
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            double prog = progress / 100;
            print('prog --------- $prog');
            setState(() {
              lineProgress = prog;
            });
          }):
      Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        color: Colors.white,
      );
    }else{
      webWidget = new InAppWebView(
          initialUrl: widget.webUrl,
          initialHeaders: {},
          initialOptions: {},
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            print("started -------------- $url");
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            double prog = progress / 100;
            print('prog --------- $prog');
            setState(() {
              lineProgress = prog;
            });
          });
    }

    // TODO: implement build
    return  Scaffold(
               appBar: AppBar(
                 leading: IconButton(
                   icon: Icon(Icons.arrow_back_ios,color: Colours.material_bg,),
                   onPressed: (){
                     NavigatorUtils.goBack(context);
                   },
                 ),
                 backgroundColor: Colours.app_main,
                 title: Text(widget.title),
                 centerTitle:true,
                 bottom: PreferredSize(
                   child: _progressBar(lineProgress,context),
                   preferredSize: Size.fromHeight(3.0),
                 ),
               ),
          body: Container(
            width:  MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height,
            child: webWidget,
          ),
    );
  }

  _progressBar(double progress,BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
    );
  }
}

