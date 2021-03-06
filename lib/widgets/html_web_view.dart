
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ruzhou/utils/MyInAppBrowser.dart';

import 'app_bar.dart';
import 'load_image.dart';


class HtmlWebView extends StatefulWidget {
  final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new MyInAppBrowser());
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
    super.initState(); ///用_futureBuilderFuture来保存_gerData()的结果，以避免不必要的ui重绘:相关blog地址：https://blog.csdn.net/u011272795/article/details/83010974
  }


  Future  _openBrowser(String url) async{
    await widget.browser.open(
        url: "$url",
        options: ChromeSafariBrowserClassOptions(
            androidChromeCustomTabsOptions: AndroidChromeCustomTabsOptions(addShareButton: false),
            iosSafariOptions: IosSafariOptions(barCollapsingEnabled: true)));
  }

  @override
  Widget build(BuildContext context) {
    if(widget.type==0){
      webWidget = new InAppWebView(
          initialFile: widget.webUrl,
          initialHeaders: {},
          initialOptions: InAppWebViewWidgetOptions(
              inAppWebViewOptions: InAppWebViewOptions(
                debuggingEnabled: true,
              )
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            print("started -------------- $url");
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            double prog = progress / 100;
            print('prog --------- $prog');
          });
    }else{
      webWidget = new InAppWebView(
          initialUrl: widget.webUrl,
          initialHeaders: {},
          initialOptions: InAppWebViewWidgetOptions(
              inAppWebViewOptions: InAppWebViewOptions(
                useShouldOverrideUrlLoading:true,
                debuggingEnabled: true,
              )
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            print("started -------------- $url");
            print(url.startsWith("http:"));
            print(url.startsWith("https:"));
          },
          shouldOverrideUrlLoading: (InAppWebViewController controller, String url) {
            print("override $url");
            if (!url.startsWith("http")) {
              controller.stopLoading();
            }else{
              this._openBrowser(url);
            }
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            double prog = progress / 100;
            print('prog --------- $prog');
          });
    }

    // TODO: implement build
    return  Scaffold(
               appBar:MyAppBar(
                 isBack: true,
                 centerTitle: '${widget.title}',
               ),
              body: Container(
                width:  MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.height,
                child: webWidget,
              ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

