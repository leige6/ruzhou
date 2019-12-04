import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';


class HtmlWebView extends StatefulWidget {
  HtmlWebView({Key key}) : super(key: key);

  @override
  _HtmlWebViewState createState() => _HtmlWebViewState();
}

class _HtmlWebViewState extends State<HtmlWebView> {

  String filePath = 'assets/html/shuiyin.html';



  Future<String> _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    return fileHtmlContents;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadHtmlFromAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Text('Title'),
              Expanded( // 注意必须加这个, 否则webview没有高度
                child: InAppWebView( initialData: InAppWebViewInitialData(snapshot.data)),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}