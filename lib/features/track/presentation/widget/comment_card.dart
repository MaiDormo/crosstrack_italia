import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentCard extends ConsumerWidget {
  final Comment comment;
  final VoidCallback? onRemove;

  const CommentCard({
    Key? key,
    required this.comment,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).currentUser;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 4.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.userName ?? 'Guest',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RatingBarIndicator(
                        rating: comment.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        unratedColor: Colors.amber.withAlpha(50),
                        itemCount: 5,
                        itemSize: 20.0.r,
                        direction: Axis.horizontal,
                      ),
                      8.verticalSpace,
                      Text(comment.text),

                      // Display the rating as stars
                    ],
                  ),
                ),
              ),
              if (user != null && comment.userId == user.uid)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  onPressed: onRemove,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
