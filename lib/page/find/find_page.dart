import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruzhou/utils/toast.dart';
import 'package:ruzhou/widgets/selected_images.dart';

import 'package:ruzhou/widgets/selected_image.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}


class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin{

  List<File> _imageFiles=[];
  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor:Colors.blue,
        title: new Text('发现'),
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top:ScreenUtil.getInstance().setHeight(24.0),
            left: ScreenUtil.getInstance().setWidth(35.0),
            right: ScreenUtil.getInstance().setWidth(35.0),
            bottom: ScreenUtil.getInstance().setHeight(24.0),
          ),
          color: Colors.white,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  maxLines: 6,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    hintText: '这一刻你的想法...',
                    contentPadding: EdgeInsets.only(left: 10,top: 2),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none),
                  ),
                ),
                SelectedImages(total:9),
              ]
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}