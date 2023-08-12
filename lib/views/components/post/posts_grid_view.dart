import 'package:crosstrack_italia/views/components/post/post_thumbnail_view.dart';
import 'package:flutter/material.dart';

import '../../../states/posts/models/post.dart';

//takes care of displaying the post
//thumbnail in a grid view

class PostGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            ///TODO: navigate to the post details view.
          },
        );
      },
    );
  }
}
