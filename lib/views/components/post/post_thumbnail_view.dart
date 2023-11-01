import 'package:flutter/material.dart';

import '../../../features/posts/models/post.dart';

//keep on mind, this stateless widget is not aware of what it has to do,
//it just knows that when tapped it has to call a voidCallback function

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;

  const PostThumbnailView({
    super.key,
    required this.post,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
