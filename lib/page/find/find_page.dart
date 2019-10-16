import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}


class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Text(
          '发现',
          style: TextStyle(
              fontSize: ScreenUtil.instance.setSp(28.0),
              color: Colors.deepOrangeAccent),
        )
    );
  }

}