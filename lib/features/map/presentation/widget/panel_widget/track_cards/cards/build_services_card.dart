import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildServicesCard(
  Track trackSelected,
  BuildContext context,
) =>
    Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Column(
                children: [
                  buildServicesHeader(context, ref),
                  ...trackSelected.services!.entries
                      .map((entry) => buildServiceRow(context, ref, entry))
                      .toList(),
                ],
              );
            },
          ),
        ),
      ),
    );

Widget buildServicesHeader(
  BuildContext context,
  WidgetRef ref,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Servizi: ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return buildServiceSwitch(context, ref);
          },
        ),
      ],
    );

Widget buildServiceSwitch(
  BuildContext context,
  WidgetRef ref,
) {
  final _value = ref.watch(toggleIconsServicesViewProvider);
  return Tooltip(
    message: 'Cambia vista',
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).colorScheme.onSecondary,
    ),
    textStyle: TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.bold,
    ),
    child: Switch(
      value: _value,
      activeColor: Theme.of(context).colorScheme.secondary,
      activeTrackColor: Theme.of(context).colorScheme.onSecondary,
      inactiveThumbColor: Theme.of(context).colorScheme.secondary,
      inactiveTrackColor: Theme.of(context).colorScheme.onSecondary,
      onChanged: (value) =>
          ref.read(toggleIconsServicesViewProvider.notifier).toggle(),
    ),
  );
}

Widget buildServiceRow(
  BuildContext context,
  WidgetRef ref,
  MapEntry<String, String> entry,
) {
  final value = ref.watch(toggleIconsServicesViewProvider);
  final entryKeyCleaned = entry.key.replaceAll('_', ' ');
  final icon = switch (entryKeyCleaned) {
    'prese 220V' => Icons.bolt,
    'bar' => Icons.wine_bar,
    'illuminazione notturna' => Icons.nightlight_round,
    'doccia calda' => Icons.shower,
    'doccia fredda' => Icons.shower,
    _ => Icons.check_circle_outline,
  };

  return Row(
    children: [
      value
          ? Icon(icon, color: Theme.of(context).colorScheme.onSecondary)
          : Text(
              entryKeyCleaned + ':',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 9.75.h,
                fontWeight: FontWeight.bold,
              ),
            ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
        child: switch (entry.value) {
          'si' => Icon(
              Icons.check,
              color: Colors.greenAccent,
              size: 13.5.h,
            ),
          'no' => Icon(
              Icons.close,
              color: Colors.redAccent,
              size: 13.5.h,
            ),
          _ => Container(),
        },
      ),
    ],
  );
}
