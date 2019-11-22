import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GalleryImageEntity extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;

  GalleryImageEntity(this.id,this.type,this.url,);

  factory GalleryImageEntity.fromJson(Map<String, dynamic> srcJson) => _$GalleryImageEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GalleryImageEntityToJson(this);

}

GalleryImageEntity _$GalleryImageEntityFromJson(Map<String, dynamic> json) {
  return GalleryImageEntity(
      json['id'] as int,
      json['type'] as String,
      json['url'] as String,
  );
}

Map<String, dynamic> _$GalleryImageEntityToJson(GalleryImageEntity instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'url': instance.url,
};