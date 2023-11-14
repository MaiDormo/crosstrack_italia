import 'package:crosstrack_italia/features/auth/providers/is_logged_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_image_provider.g.dart';

@riverpod
Future<Widget> userImage(UserImageRef ref) async {
  final isLogged = ref.watch(isLoggedInProvider);
  final userProfileInfo = FirebaseAuth.instance.currentUser;

  if (isLogged && userProfileInfo != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.network(
        userProfileInfo.photoURL!.toString(),
        fit: BoxFit.cover,
        width: 35,
        height: 35,
      ),
    );
  } else {
    return Icon(Icons.account_circle);
  }
}
