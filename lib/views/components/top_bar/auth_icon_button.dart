import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/views/login/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthIconButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isLogged = ref.watch(isLoggedInProvider);
    final userImage = ref.watch(userImageProvider);

    return Container(
      width: 82.28.w,
      child: IconButton(
        onPressed: () {
          if (!_isLogged) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPageView()),
            );
          }
        },
        icon: userImage,
        iconSize: 28.8.w,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
