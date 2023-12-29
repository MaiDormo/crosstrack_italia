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
            color: Theme.of(context).colorScheme.primary,
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
      color: Colors.orange,
    ),
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    child: Switch(
      value: _value,
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
          ? Icon(icon)
          : Text(
              entryKeyCleaned + ':',
              style: TextStyle(
                color: Colors.black,
                fontSize: 9.75.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
      Card(
        child: Padding(
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
      ),
    ],
  );
}
