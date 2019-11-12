import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TabEntity extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'url')
  String url;

  TabEntity(this.id,this.name,this.code,this.url);

  factory TabEntity.fromJson(Map<String, dynamic> srcJson) => _$TabEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabEntityToJson(this);

}

TabEntity _$TabEntityFromJson(Map<String, dynamic> json) {
  return TabEntity(
      json['id'] as int,
      json['name'] as String,
      json['code'] as String,
      json['url'] as String,
  );
}

Map<String, dynamic> _$TabEntityToJson(TabEntity instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'url': instance.url,
};