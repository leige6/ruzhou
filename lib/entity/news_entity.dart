import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NewsEntity extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'from')
  String from;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'isTop')
  bool isTop;

  @JsonKey(name: 'imgageUrl')
  String imgageUrl;

  NewsEntity(this.id,this.title,this.from,this.commentCount,this.time,this.isTop,this.imgageUrl);

  factory NewsEntity.fromJson(Map<String, dynamic> srcJson) => _$NewsEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsEntityToJson(this);

}

NewsEntity _$NewsEntityFromJson(Map<String, dynamic> json) {
  return NewsEntity(
      json['id'] as int,
      json['title'] as String,
      json['from'] as String,
      json['commentCount'] as int,
      json['time'] as String,
      json['isTop'] as bool,
      json['imgageUrl'] as String,
  );
}

Map<String, dynamic> _$NewsEntityToJson(NewsEntity instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'from': instance.from,
  'commentCount': instance.commentCount,
  'time': instance.time,
  'isTop': instance.isTop,
  'imgageUrl': instance.imgageUrl,
};