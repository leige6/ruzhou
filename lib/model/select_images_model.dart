import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:ruzhou/entity/gallery_image_entity.dart';

class SelectImagesModel with ChangeNotifier {

  int _index=0;

  int _length=0;

  List<GalleryImageEntity> _galleryImageEntitys=<GalleryImageEntity>[new GalleryImageEntity(0, 'icon', 'icon_plus')];

  List<GalleryImageEntity> get galleryImageEntitys => _galleryImageEntitys;
  int get index => _index;

  int get length => _galleryImageEntitys.length;

  void add(GalleryImageEntity entity) {
    _galleryImageEntitys.insert(_galleryImageEntitys.length-1,entity);
    notifyListeners(); //通知更新数据
  }

  void removeAt(int index) {
    _galleryImageEntitys.removeAt(index);
    notifyListeners(); //通知更新数据
  }

  void setIndex(int index) {
    _index=index;
    notifyListeners(); //通知更新数据
  }

  @override
  void dispose() {
    super.dispose();
  }
}