import '../../user_info/providers/user_info_providers.dart';
import '../models/comment.dart';
import '../models/typedefs/typedefs.dart';
import '../notifiers/track_notifier.dart';
import 'widget/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsSection extends ConsumerStatefulWidget {

  const CommentsSection({
    super.key,
    required this.trackId,
  });
  final TrackId trackId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsSection> {
  final commentController = TextEditingController();
  double userRating = 0;

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  void addComment(TrackId id) {
    ref.read(trackProvider.notifier).addComment(
          context,
          commentController.text.trim(),
          id,
          userRating,
        );
    setState(() {
      commentController.text = '';
      userRating = 0;
    });
    Navigator.of(context).pop(); // Close the pop-up after adding a comment
  }

  void removeComment(Comment comment) {
    ref.read(trackProvider.notifier).removeComment(
          comment,
          context,
        );
  }

  void _showNeedToLoginSnackBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.login_rounded, color: Colors.white, size: 20.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Accedi per poter completare questa operazione',
                style: GoogleFonts.poppins(fontSize: 14.sp),
              ),
            ),
          ],
        ),
        backgroundColor: colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _showCommentDialog() {
    final colorScheme = Theme.of(context).colorScheme;
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.rate_review_rounded,
                      color: colorScheme.primary,
                      size: 22.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Aggiungi recensione',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valutazione',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: RatingBar(
                        initialRating: userRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0).w,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star_rounded, color: Color(0xFFFBBF24)),
                          half: const Icon(Icons.star_half_rounded, color: Color(0xFFFBBF24)),
                          empty: Icon(Icons.star_outline_rounded, color: colorScheme.onSurface.withValues(alpha: 0.2)),
                        ),
                        onRatingUpdate: (rating) {
                          setDialogState(() {
                            userRating = rating;
                          });
                          setState(() {
                            userRating = rating;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Commento',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: commentController,
                      maxLines: 4,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Scrivi la tua esperienza...',
                        hintStyle: GoogleFonts.poppins(
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: colorScheme.onSurface.withValues(alpha: 0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: colorScheme.primary.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(16.r),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'Annulla',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  ),
                  onPressed: () => addComment(widget.trackId),
                  icon: Icon(Icons.send_rounded, size: 18.r),
                  label: Text(
                    'Pubblica',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
              actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Add comment button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isLoggedIn
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.1),
                foregroundColor: isLoggedIn ? Colors.white : colorScheme.onSurface.withValues(alpha: 0.4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: isLoggedIn
                  ? _showCommentDialog
                  : () => _showNeedToLoginSnackBar(context),
              icon: Icon(Icons.add_comment_rounded, size: 20.r),
              label: Text(
                'Scrivi una recensione',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 8.h),
        
        // Comments list
        ref.watch(fetchCommentsByTrackIdProvider(widget.trackId)).when(
          data: (comments) {
            if (comments.isEmpty) {
              return Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 40.r,
                      color: colorScheme.onSurface.withValues(alpha: 0.2),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Nessuna recensione',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Sii il primo a lasciare una recensione!',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: comments.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: colorScheme.onSurface.withValues(alpha: 0.08),
                indent: 16.w,
                endIndent: 16.w,
              ),
              itemBuilder: (context, index) {
                final comment = comments.elementAt(index);
                return CommentCard(
                  comment: comment,
                  onRemove: () => removeComment(comment),
                );
              },
            );
          },
          loading: () => Padding(
            padding: EdgeInsets.all(24.r),
            child: Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
                strokeWidth: 2,
              ),
            ),
          ),
          error: (error, stackTrace) => Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 40.r,
                  color: const Color(0xFFEF4444),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Errore nel caricamento',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  error.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
      ],
    );
  }
}
