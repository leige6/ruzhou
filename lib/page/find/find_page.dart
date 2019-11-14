import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruzhou/utils/toast.dart';

import 'package:ruzhou/widgets/selected_image.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}


class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin{

  File _imageFile;

  void _getImage() async{
    try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor:Colors.blue,
        title: new Text('发现'),
      ),
      body:Container(
        padding: EdgeInsets.only(
          top:ScreenUtil.getInstance().setHeight(24.0),
          left: ScreenUtil.getInstance().setWidth(20.0),
          right: ScreenUtil.getInstance().setWidth(20.0),
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
              SelectedImage(
                  image: _imageFile,
                  onTap: _getImage
              ),
            ]
        ),
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}