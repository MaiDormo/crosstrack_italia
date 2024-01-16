import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/user_info/constants/user_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_settings.dart';
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
          AsyncError() => MapConstans.errorLocation,
          _ => MapConstans.loading,
        },
        style: TextStyle(
          fontSize: 12.3.sp,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
