

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/entity/selectd_images_entity.dart';
import 'package:ruzhou/router/find_router.dart';
import 'package:ruzhou/router/fluro_convert_util.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:ruzhou/utils/image_utils.dart';
import 'package:ruzhou/widgets/image_gallery.dart';

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

class _SelectedImagesState extends State<SelectedImages> with AutomaticKeepAliveClientMixin{
  File _imageFile;
  List<SelectdImagesEntity> images=<SelectdImagesEntity>[new SelectdImagesEntity(type: 'icon')];
  List<GalleryImageEntity> list=<GalleryImageEntity>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(
        top:ScreenUtil.getInstance().setHeight(24.0),
        left: ScreenUtil.getInstance().setWidth(20.0),
        right: ScreenUtil.getInstance().setWidth(20.0),
      ),
      child: Wrap(
        spacing: 5, //主轴上子控件的间距
        runSpacing: 5, //交叉轴上子控件之间的间距
        // 扩展方式，横向堆砌
        direction: Axis.horizontal,
        // 对齐方式
        alignment: WrapAlignment.start,
        // run的对齐方式
        runAlignment: WrapAlignment.start,
        // 交叉轴对齐方式
        // crossAxisAlignment: WrapCrossAlignment.end,
        children: Boxs(), //要显示的子控件集合
      ),
    );
  }


  void onTap (){
   showModalBottomSheet(
      context: context,
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
                      if(image!=null){
                        setState(() {
                          SelectdImagesEntity entity=new SelectdImagesEntity(type: 'file',file: image);
                          images.insert(images.length-1,entity);
                          GalleryImageEntity gaEntity=new GalleryImageEntity(list.length+1, 'local', image.path);
                          list.add(gaEntity);
                          if(images.length>widget.total){
                            images.removeLast();
                          }
                        });
                      }
                },
                ),
                new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("相册"),
                onTap: () async {
                Navigator.pop(context);
                    var image  = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality:50);
                    if(image!=null){
                      setState(() {
                        SelectdImagesEntity entity=new SelectdImagesEntity(type: 'file',file: image);
                        images.insert(images.length-1,entity);
                        GalleryImageEntity gaEntity=new GalleryImageEntity(list.length+1, 'local', image.path);
                        list.add(gaEntity);
                        if(images.length>widget.total){
                          images.removeLast();
                        }
                      });
                    }
                },
                ),
          ],
         );
    }
  );
  }

  List<Widget> Boxs() => List.generate(images.length, (index) {
    SelectdImagesEntity entity=images[index];
    return  entity.type=='icon'?
    InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:Colours.select_image_bg,
          image:DecorationImage(
              image: ImageUtils.getAssetImage("icon_plus") ,
              fit: BoxFit.none
          ),
        ),
      ),
    ):InkWell(
      onTap: (){
        _jumpToGallery(index,list);
      },
      child: Container(
        width: 110,
        height: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image:DecorationImage(
              image: FileImage(entity.file),
              fit: BoxFit.cover
          ),
        ),
      ),
    );
  });


  void _jumpToGallery(inde, list) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder:(context)=>new ImageGallery(photoList:list,index:inde)
        )
    );
    /// 对中文进行编码
    /// 对自定义类型 转为 json string
   /* String listJson = jsonEncode(list);
    print('---------------图片json----------------------'+listJson);
    NavigatorUtils.pushResult(context,FindRouter.imageGalleryPage + "?index=$index&photoList=${Uri.encodeComponent(listJson)}",Feedback);*/
  }

  void  Feedback(result){
      if(result!=null){
        String listJson = jsonEncode(result);
        print('---------------回调json----------------------'+listJson);
        if(!mounted){
          return;
        }
        setState(() {
          images.clear();
          for(int i=0;i<result.length;i++){
            GalleryImageEntity entity=result[i];
            SelectdImagesEntity selectEntity=new SelectdImagesEntity(type: 'file',file: new File(entity.url));
            images.add(selectEntity);
          }
        });
      }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  /*@override
  void dispose() {
    super.dispose();
  }*/
}