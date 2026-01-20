import '../../models/comment.dart';
import '../../../../firebase_providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends ConsumerWidget {

  const CommentCard({
    Key? key,
    required this.comment,
    required this.onRemove,
  }) : super(key: key);
  final Comment comment;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).currentUser;
    final colorScheme = Theme.of(context).colorScheme;
    final isOwnComment = user != null && comment.userId == user.uid;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                comment.userName.isNotEmpty 
                    ? comment.userName[0].toUpperCase()
                    : '?',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and rating row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.userName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    RatingBarIndicator(
                      rating: comment.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFBBF24),
                      ),
                      unratedColor: colorScheme.onSurface.withValues(alpha: 0.1),
                      itemCount: 5,
                      itemSize: 14.r,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                // Comment text
                Text(
                  comment.text,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          // Delete button for own comments
          if (isOwnComment)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Material(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onRemove,
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: const Color(0xFFEF4444),
                      size: 18.r,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
