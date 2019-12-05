
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/widgets/water_mark.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}


class _MinePageState extends State<MinePage>  with AutomaticKeepAliveClientMixin{
  Rect _rect;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WaterMark(waterText:"汝州本地通",opacity:0.5),
       Container(
          constraints: BoxConstraints.expand(
             height: MediaQuery.of(context).size.height,
          ),
          child: Center(
           child: Text("我的",style: TextStyle(
            color: Colours.red
           )),
         ),
      ),
      ],
    );


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}