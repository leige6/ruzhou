import 'package:flutter/material.dart';
import 'package:ruzhou/constant/colours.dart';

import 'fluro_navigator.dart';

class WidgetNotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new AppBar(
        backgroundColor:Colours.app_main,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colours.material_bg,),
          onPressed: (){
            NavigatorUtils.goBack(context);
          },
        ),
        centerTitle: true,
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
