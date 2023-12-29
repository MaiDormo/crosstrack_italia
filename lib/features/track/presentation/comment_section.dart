import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  void addComment(TrackId id) {
    ref.read(trackNotifierProvider.notifier).addComment(
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
    ref.read(trackNotifierProvider.notifier).removeComment(
          comment,
          context,
        );
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text('Aggiungi un commento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0).w,
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
              16.verticalSpace,
              TextFormField(
                controller: commentController,
                maxLines: 5, // Imposta il numero massimo di righe
                decoration: InputDecoration(
                  hintText: 'Inserisci un commento',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  border: OutlineInputBorder(), // Bordo del campo di testo
                  contentPadding: const EdgeInsets.all(12).r, // Padding interno
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il pop-up
              },
              child: Text(
                'Cancella',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            15.horizontalSpace,
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                ),
              ),
              onPressed: () => addComment(widget.trackId),
              child: Text(
                'Invia',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ref.watch(trackSelectedProvider).id;
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        16.verticalSpace,
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blueGrey,
            ),
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          onPressed: isLoggedIn ? _showCommentDialog : null,
          child: const Text('Commenta'),
        ),
        16.verticalSpace,
        ref.watch(fetchCommentsByTrackIdProvider(id)).when(
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
