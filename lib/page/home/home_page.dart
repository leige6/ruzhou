import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Text(
         '首页',
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(28.0),
              color: Colors.deepOrangeAccent),
        )
    );
  }

}