import '../../../features/user_info/providers/user_info_providers.dart';
import '../../login/login_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginIcon extends ConsumerWidget {
  const loginIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogged = ref.watch(isLoggedInProvider);
    final userImage = ref.watch(userImageProvider);
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: IconButton(
        onPressed: () {
          if (!isLogged) {
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
