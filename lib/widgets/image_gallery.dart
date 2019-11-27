
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/router/fluro_navigator.dart';

import 'app_bar.dart';

class ImageGallery extends StatefulWidget {
  final List photoList;
  final int index;
  ImageGallery({Key key,this.photoList, this.index}):super(key:key);
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery>{
  int currentIndex = 0;
  int initialIndex; //初始index
  int length;
  int title;
  String type;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.photoList.length;
    title = initialIndex + 1;
    pageController=PageController(initialPage: initialIndex);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = index + 1;
    });
  }

  void delete() {
    setState(() {
      length=length-1;
      widget.photoList.removeAt(currentIndex);
      if(length==0){
        NavigatorUtils.goBackWithParams(context, widget.photoList);
      }
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      //监听物理按键返回
      onWillPop: (){
        NavigatorUtils.goBackWithParams(context, widget.photoList);
      },
      child:  Scaffold(
        appBar: MyAppBar(
          backgroundColor:Colors.blue,
          centerTitle: '${title} / ${length}',
          actionName:'删除',
          onBack: (){
            NavigatorUtils.goBackWithParams(context, widget.photoList);
          },
          onPressed:delete,
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollDirection: Axis.horizontal,
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    GalleryImageEntity entity=widget.photoList[index];
                    return PhotoViewGalleryPageOptions(
                      imageProvider: entity.type=='local'? FileImage(new File(entity.url)):NetworkImage(entity.url),
                      initialScale: PhotoViewComputedScale.contained * 1,
                      heroTag: entity.type=='local'?index:entity.id,
                    );
                  },
                  itemCount: widget.photoList.length,
                  // loadingChild: widget.loadingChild,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  pageController:pageController, //点进去哪页默认就显示哪一页
                  onPageChanged: onPageChanged,
                  enableRotation: false,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Image ${currentIndex + 1}",
                    style: const TextStyle(color: Colors.white, fontSize: 17.0, decoration: null),
                  ),
                )
              ],
            )),
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