import 'package:crosstrack_italia/common/resposive.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/comment_card.dart';
import 'package:crosstrack_italia/map_screen_view.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        );
    setState(() {
      commentController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider)!;
    // final isGuest = !user.isAuthenticated;
    final trackId = ref.watch(trackSelectedProvider)?.trackWebCode ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        TextField(
          controller: commentController,
          onSubmitted: (_) => addComment(trackId),
          decoration: const InputDecoration(
            hintText: 'Commenta',
            filled: true,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 8),

        //button to add comment
        ElevatedButton(
          onPressed: () => addComment(trackId),
          child: const Text('Commenta'),
        ),

        const SizedBox(height: 16),

        ref.watch(fetchCommentsByTrackIdProvider(trackId)).when(
              data: (comments) => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments.elementAt(index);
                  print(comment);
                  return CommentCard(
                    comment: comment,
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
