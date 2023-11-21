import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationText extends ConsumerWidget {
  const LocationText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(getClosestLocationProvider);
    return Text(
      location.when(
        data: (data) => data,
        loading: () => 'Loading...',
        error: (error, stackTrace) {
          return 'Error';
        },
      ),
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.03,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}