import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildServicesCard(
        Track trackSelected, BuildContext context, double heightFactor) =>
    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Column(
                children: [
                  buildServicesHeader(heightFactor, context, ref),
                  ...trackSelected.services!.entries
                      .map((entry) =>
                          buildServiceRow(context, ref, entry, heightFactor))
                      .toList(),
                ],
              );
            },
          ),
        ),
      ),
    );

Widget buildServicesHeader(
        double heightFactor, BuildContext context, WidgetRef ref) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Servizi: ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16 * heightFactor,
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

Widget buildServiceSwitch(BuildContext context, WidgetRef ref) {
  final _value = ref.watch(toggleIconsServicesViewProvider);
  return Tooltip(
    message: 'Switch between text and icons',
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

Widget buildServiceRow(BuildContext context, WidgetRef ref,
    MapEntry<String, String> entry, double heightFactor) {
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
                fontSize: 13 * heightFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
      Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: switch (entry.value) {
            'si' => Icon(
                Icons.check,
                color: Colors.greenAccent,
                size: 18 * heightFactor,
              ),
            'no' => Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 18 * heightFactor,
              ),
            _ => Container(),
          },
        ),
      ),
    ],
  );
}
