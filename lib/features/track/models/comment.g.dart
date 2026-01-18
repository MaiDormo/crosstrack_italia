// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: json['id'] as String,
  trackId: json['trackId'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  text: json['text'] as String,
  date: DateTime.parse(json['date'] as String),
  rating: (json['rating'] as num).toDouble(),
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'trackId': instance.trackId,
  'userId': instance.userId,
  'userName': instance.userName,
  'text': instance.text,
  'date': instance.date.toIso8601String(),
  'rating': instance.rating,
};
