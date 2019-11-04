import 'package:json_annotation/json_annotation.dart';

import 'news_entity.dart';




@JsonSerializable()
class HomeEntity extends Object {

  @JsonKey(name: 'newsList')
  List<NewsEntity> newsList;

  HomeEntity(this.newsList,);

  factory HomeEntity.fromJson(Map<String, dynamic> srcJson) => _$HomeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeEntityToJson(this);

}



HomeEntity _$HomeEntityFromJson(Map<String, dynamic> json) {
  return HomeEntity(
      (json['newsList'] as List)
          ?.map((e) =>
      e == null ? null : NewsEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HomeEntityToJson(HomeEntity instance) =>
    <String, dynamic>{
      'newsList': instance.newsList,
    };










