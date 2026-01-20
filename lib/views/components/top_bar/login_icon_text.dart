import '../../../features/user_info/constants/user_constants.dart';
import '../../../features/user_info/notifiers/user_settings.dart';
import '../../../features/user_info/providers/user_info_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginIconText extends ConsumerWidget {
  const loginIconText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogged = ref.watch(isLoggedInProvider);
    return Visibility(
      visible: !isLogged &&
          ref.watch(userSettingsProvider)[UserConstants.showMoreInfo]!,
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 12.3.sp,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
