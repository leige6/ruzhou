import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruzhou/utils/toast.dart';
import 'package:ruzhou/widgets/select_images.dart';

import 'package:ruzhou/widgets/selected_image.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}


class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin{

  File _imageFile;

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
      body:Container(
        padding: EdgeInsets.only(
          top:ScreenUtil.getInstance().setHeight(24.0),
          left: ScreenUtil.getInstance().setWidth(35.0),
          right: ScreenUtil.getInstance().setWidth(35.0),
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
            /*  SelectedImage(
                  image: _imageFile,
                  onTap: (){
                    showModalBottomSheet(
                        context: _scaffoldKey.currentContext,
                        builder: (BuildContext context){
                          return new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new ListTile(
                                leading: new Icon(Icons.photo_camera),
                                title: new Text("拍照"),
                                onTap: () async {
                                  Navigator.pop(context);
                                  var image  = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality:50);
                                  setState(() {
                                    _imageFile = image;
                                  });
                                },
                              ),
                              new ListTile(
                                leading: new Icon(Icons.photo_library),
                                title: new Text("相册"),
                                onTap: () async {
                                  Navigator.pop(context);
                                  var image  = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality:50);
                                  setState(() {
                                    _imageFile = image;
                                  });

                                },
                              ),
                            ],
                          );
                        }
                    );
                  }
              ),*/
            ]
        ),
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}