import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required String id,
    required TrackId trackId,
    required String userId,
    required String userName,
    required String text,
    required DateTime date,
    required double rating,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
