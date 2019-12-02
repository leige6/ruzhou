
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/model/select_images_model.dart';
import 'package:ruzhou/model/store.dart';
import 'package:ruzhou/router/fluro_navigator.dart';

import 'app_bar.dart';

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery>{
  List<GalleryImageEntity> galleryImageEntitys;
  int currentIndex = 0;
  int initialIndex; //初始index
  int length;
  int title;
  String type;
  PageController pageController;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    initialIndex=Provider.of<SelectImagesModel>(context).index;
    galleryImageEntitys=Provider.of<SelectImagesModel>(context).galleryImageEntitys;
    currentIndex = initialIndex;
    length = galleryImageEntitys.length-1; //不展示‘+’号图片
    pageController=PageController(initialPage: initialIndex);
    return WillPopScope(
      //监听物理按键返回
      onWillPop: (){
        NavigatorUtils.goBack(context);
      },
      child:  Scaffold(
        appBar: MyAppBar(
          backgroundColor:Colors.blue,
          centerTitle: '${Provider.of<SelectImagesModel>(context).index+1} / ${length}',
          actionName:'删除',
          onBack: (){
            NavigatorUtils.goBack(context);
          },
          onPressed:() {
            //length=length-1;
            Provider.of<SelectImagesModel>(context).removeAt(currentIndex);
            if(length==0){
              NavigatorUtils.goBack(context);
            }
          },
        ),
        body:  Store.connect<SelectImagesModel>( builder: (ctx, selectImages, child) {
          return Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                //alignment: Alignment.bottomRight,
                children: <Widget>[
                  PhotoViewGallery.builder(
                    scrollDirection: Axis.horizontal,
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      GalleryImageEntity entity=galleryImageEntitys[index];
                      return PhotoViewGalleryPageOptions(
                        imageProvider: entity.type=='local'? FileImage(new File(entity.url)):NetworkImage(entity.url),
                        initialScale: PhotoViewComputedScale.contained * 1,
                        heroTag: entity.type=='local'?index:entity.id,
                      );
                    },
                    itemCount: length,
                    // loadingChild: widget.loadingChild,
                    backgroundDecoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController:pageController, //点进去哪页默认就显示哪一页
                    onPageChanged: (index){
                      currentIndex=index;
                      Store.value<SelectImagesModel>(context).setIndex(index);
                    },
                    enableRotation: false,
                  )
                ],
              ));
        }),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

}