import '../../constants/map_constants.dart';
import '../../notifiers/user_location_notifier.dart';
import '../../../user_info/constants/user_constants.dart';
import '../../../user_info/notifiers/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationText extends ConsumerWidget {
  const LocationText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(getLocationPlaceStringProvider);
    final showLocationText =
        ref.watch(userSettingsProvider)[UserConstants.showLocationTopBar]!;
    return Visibility(
      visible: showLocationText,
      child: Text(
        switch (location) {
          AsyncData(:final value) => value,
          AsyncError() => MapConstants.errorLocation,
          _ => MapConstants.loading,
        },
        style: TextStyle(
          fontSize: 12.3.sp,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
