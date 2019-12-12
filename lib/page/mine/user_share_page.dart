import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ruzhou/constant/colours.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/model/select_images_model.dart';
import 'package:ruzhou/model/store.dart';
import 'package:ruzhou/router/find_router.dart';
import 'package:ruzhou/router/fluro_navigator.dart';
import 'package:ruzhou/utils/image_utils.dart';
import 'package:ruzhou/utils/utils.dart';
import 'package:ruzhou/widgets/app_bar.dart';
import 'package:ruzhou/widgets/find_my_text_filed.dart';

class UserSharePage extends StatefulWidget {
  @override
  _UserSharePageState createState() => _UserSharePageState();
}


class _UserSharePageState extends State<UserSharePage> with AutomaticKeepAliveClientMixin{
  int total= 9;
  List<GalleryImageEntity> galleryImageEntitys;
  int length=0;
  static final TextEditingController _textController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        appBar: MyAppBar(
          isBack: true,
          centerTitle: '分享',
        ),
        body:defaultTargetPlatform == TargetPlatform.iOS ?FormKeyboardActions(
          child: _buildBody(),
        ) :SingleChildScrollView(
            child: _buildBody()
        )
    );
  }

  _buildBody(){
    return  Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
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
            FindMyTextField(
              focusNode: _nodeText1,
              controller: _textController,
              config: Utils.getKeyboardActionsConfig(context, [_nodeText1]),
            ),
            Store.connect<SelectImagesModel>( builder: (ctx, selectImages, child) {
              galleryImageEntitys=selectImages.galleryImageEntitys;
              length=selectImages.length>9?9:selectImages.length;
              return  Container(
                padding: EdgeInsets.fromLTRB(15, 16, 15, 8),
                child: GridView.builder(
                  shrinkWrap: true, //解决 listview 嵌套报错
                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                      crossAxisCount: 3,
                      //纵轴间距
                      mainAxisSpacing: 10.0,
                      //横轴间距
                      crossAxisSpacing: 10.0,
                      //子组件宽高长度比例
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    GalleryImageEntity entity=galleryImageEntitys[index];
                    return GestureDetector(
                        onTap: (){
                          selectImages.setIndex(index);
                          entity.type=='icon'?_selectImage():_jumpToGallery();
                        },
                        child: entity.type=='icon'?
                        Container(
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
                        ):Image.file(new File(entity.url), width: 110,
                            height: 110,fit: BoxFit.cover)
                    );
                  },
                  itemCount: length,
                ),
              );
            }
            )
          ]
      ),
    );
  }

  void _selectImage (){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Padding(
            padding:EdgeInsets.only(
              bottom: ScreenUtil.getInstance().setHeight(50.0),
            ),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Store.connect<SelectImagesModel>(
                  builder: (ctx, selectImages, child) {
                    return new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text("拍照"),
                      onTap: () async {
                        Navigator.pop(context);
                        var image  = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality:50);
                        if(image!=null){
                          GalleryImageEntity gaEntity=new GalleryImageEntity(selectImages.length-1, 'local', image.path);
                          selectImages.add(gaEntity);
                        }
                      },
                    );
                  },
                ),
                Store.connect<SelectImagesModel>(
                    builder: (ctx, selectImages, child) {
                      return  new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text("相册"),
                        onTap: () async {
                          Navigator.pop(context);
                          var image  = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality:50);
                          if(image!=null){
                            GalleryImageEntity gaEntity=new GalleryImageEntity(selectImages.length-1, 'local', image.path);
                            selectImages.add(gaEntity);
                          }
                        },
                      );
                    }
                )
              ],
            ),
          );


        }
    );
  }

  /*void _jumpToGallery(inde, list) {
    String listJson = jsonEncode(list);
    print('---------------图片json----------------------'+listJson);
    NavigatorUtils.pushResult(context,FindRouter.imageGalleryPage + "?index=$inde&photoList=${Uri.encodeComponent(listJson)}",Feedback);
  }*/

  void _jumpToGallery() {
    NavigatorUtils.push(context,FindRouter.imageGalleryPage);
  }

  /*void  Feedback(result){
    if(result!=null){
      String listJson = jsonEncode(result);
      print('---------------回调json----------------------'+listJson);
     if(!mounted){
        return;
      }
      setState(() {
        images.clear();
        list=result;
        for(int i=0;i<result.length;i++){
          GalleryImageEntity entity=result[i];
          SelectdImagesEntity selectEntity=new SelectdImagesEntity(type: 'file',file: new File(entity.url));
          images.add(selectEntity);
        }
        if(images.length<9){
          SelectdImagesEntity selectEntity=new SelectdImagesEntity(type: 'icon');
          images.add(selectEntity);
        }
      });
    }
  }*/

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
}