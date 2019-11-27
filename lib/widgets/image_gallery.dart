
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/entity/selectd_images_entity.dart';
import 'package:ruzhou/router/fluro_navigator.dart';

import 'app_bar.dart';

class ImageGallery extends StatefulWidget {
  final List photoList;
  final int index;
  ImageGallery({Key key,this.photoList, this.index}):super(key:key);
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  @override
  int currentIndex = 0;
  int initialIndex; //初始index
  int length;
  int title;
  String type;
  @override
  void initState() {
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.photoList.length;
    title = initialIndex + 1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = index + 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor:Colors.blue,
        centerTitle: '${title} / ${length}',
        onGoBack: (){
          NavigatorUtils.goBackWithParams(context, widget.photoList);
        },
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
                    imageProvider: entity.type=='local'?FileImage(new File(entity.url)):NetworkImage(entity.url),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    heroTag: entity.type=='local'?index:entity.id,
                  );
                },
                itemCount: widget.photoList.length,
                // loadingChild: widget.loadingChild,
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
                pageController: PageController(initialPage: initialIndex), //点进去哪页默认就显示哪一页
                onPageChanged: onPageChanged,
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
    );
  }
}