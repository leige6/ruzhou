import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}


class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Center(
        child: Text(
          '我的',
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(28.0),
              color: Colors.deepOrangeAccent),
        )
    );
  }

}