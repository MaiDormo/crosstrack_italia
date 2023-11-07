// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      commentId: json['commentId'] as String,
      trackId: json['trackId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'trackId': instance.trackId,
      'userId': instance.userId,
      'userName': instance.userName,
      'text': instance.text,
      'date': instance.date.toIso8601String(),
    };
