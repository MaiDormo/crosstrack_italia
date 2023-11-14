import 'package:crosstrack_italia/features/auth/providers/is_logged_in_provider.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/comment_card.dart';
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
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
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

        //button to add comment
        ElevatedButton(
          onPressed: isLoggedIn ? () => addComment(trackId) : null,
          child: const Text('Commenta'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors
                      .grey; // Use the color you want for disabled state
                }
                return Colors.white; // Use the default color for other states
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
