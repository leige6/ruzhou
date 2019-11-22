import 'package:fluro/fluro.dart';
import 'package:ruzhou/entity/gallery_image_entity.dart';
import 'package:ruzhou/page/find/find_page.dart';
import 'package:ruzhou/page/home/home_page.dart';
import 'package:ruzhou/router/router_init.dart';
import 'package:ruzhou/widgets/image_gallery.dart';

import 'fluro_convert_util.dart';

class FindRouter implements IRouterProvider{

  static String findPage = "/find";
  static String imageGalleryPage = "/imageGallery";

  @override
  void initRouter(Router router) {
    router.define(findPage, handler: Handler(handlerFunc: (_, params) => FindPage()));
    router.define(
        imageGalleryPage, handler: Handler(handlerFunc: (context, params) {
      String ind= params['index']?.first;//取出传参
      List photoList = ( params['photoList']?.first as List)
          ?.map((e) =>
      e == null ? null : GalleryImageEntity.fromJson(e as Map<String, dynamic>))
          ?.toList();
      return ImageGallery(photoList:photoList,index:FluroConvertUtils.string2int(ind));
    }));
  }

}