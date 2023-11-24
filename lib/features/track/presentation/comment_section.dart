import 'package:crosstrack_italia/features/auth/providers/is_logged_in_provider.dart';
import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentsSection extends ConsumerStatefulWidget {
  final TrackId trackId;

  const CommentsSection({
    super.key,
    required this.trackId,
  });

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

  void addComment(TrackId trackId) {
    ref.read(trackNotifierProvider.notifier).addComment(
          context,
          commentController.text.trim(),
          trackId,
          userRating, // Pass the user's rating to the addComment function
        );
    setState(() {
      commentController.text = '';
      userRating = 0; // Reset the user's rating after submitting the comment
    });
  }

  void removeComment(Comment comment) {
    ref.read(trackNotifierProvider.notifier).removeComment(
          comment,
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final trackId = ref.watch(trackSelectedProvider)?.id ?? '';
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),

        // Star Rating Bar

        isLoggedIn
            ? Column(
                children: [
                  const Text('Vota la pista'),
                  RatingBar(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                      full: Icon(Icons.star, color: Colors.amber),
                      half: Icon(Icons.star_half, color: Colors.amber),
                      empty: Icon(Icons.star_border, color: Colors.amber),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        userRating = rating;
                      });
                    },
                  ),
                ],
              )
            : const Text('Completa il log-in per votare la pista'),

        const SizedBox(height: 16),

        TextField(
          controller: commentController,
          onSubmitted: isLoggedIn ? (_) => addComment(trackId) : null,
          enabled: isLoggedIn,
          decoration: InputDecoration(
            hintText:
                isLoggedIn ? 'Commenta' : 'Completa il log-in per commentare',
            filled: true,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 8),

        // Button to add comment
        ElevatedButton(
          onPressed: isLoggedIn ? () => addComment(trackId) : null,
          child: const Text('Commenta'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return Colors.white;
              },
            ),
          ),
        ),

        const SizedBox(height: 16),

        ref.watch(fetchCommentsByTrackIdProvider(trackId)).when(
              data: (comments) => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments.elementAt(index);
                  return CommentCard(
                    comment: comment,
                    onRemove: () => removeComment(comment),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
      ],
    );
  }
}
