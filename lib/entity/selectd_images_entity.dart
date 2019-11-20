
import 'dart:io';

class SelectdImagesEntity {

  String type;
  File file;
  SelectdImagesEntity(
      {
        this.type = 'icon',//默认为加载状态
        this.file
      });

}