

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedImages extends StatefulWidget {

  final int total; //页面状态


  SelectedImages(
      {Key key,
        this.total = 1,//默认为加载状态
      })
      : super(key: key);


  @override
  _SelectedImagesState createState() => _SelectedImagesState();

}

class _SelectedImagesState extends State<SelectedImages> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Wrap(
        spacing: 5, //主轴上子控件的间距
        runSpacing: 5, //交叉轴上子控件之间的间距
        // 扩展方式，横向堆砌
        direction: Axis.horizontal,
        // 对齐方式
        alignment: WrapAlignment.spaceAround,
        // run的对齐方式
        runAlignment: WrapAlignment.center,
        // 交叉轴对齐方式
        crossAxisAlignment: WrapCrossAlignment.end,
        children: Boxs(), //要显示的子控件集合
      ),
    );

  }

  /*一个渐变颜色的正方形集合*/
  List<Widget> Boxs() => List.generate(widget.total, (index) {
    return Container(
      width: 110,
      height: 110,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.orangeAccent,
          Colors.orange,
          Colors.deepOrange
        ]),
      ),
      child: Text(
        "${index}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  });

}