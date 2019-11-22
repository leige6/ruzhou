import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        backgroundColor:Colors.blue,
        title: new Text('页面不存在'),
      ),
      body: Container(
        child: Center(
          child: Text("页面不存在"),
        ),
      ),
    );
  }
}
