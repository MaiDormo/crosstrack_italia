import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildServicesCard(Track trackSelected, BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12.r.clamp(10.0, 16.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.r.clamp(5.0, 8.0)),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.build_circle_outlined,
                      size: 16.r.clamp(14.0, 18.0),
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 8.w.clamp(6.0, 10.0)),
                  Expanded(
                    child: Text(
                      'Servizi',
                      style: TextStyle(
                        fontSize: 13.sp.clamp(12.0, 14.0),
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  _buildViewToggle(context, ref),
                ],
              ),
              SizedBox(height: 10.h),
              ...trackSelected.services!.entries
                  .map((entry) => _buildServiceRow(context, ref, entry))
                  .toList(),
            ],
          );
        },
      ),
    ),
  );
}

Widget _buildViewToggle(BuildContext context, WidgetRef ref) {
  final value = ref.watch(toggleIconsServicesViewProvider);
  final colorScheme = Theme.of(context).colorScheme;

  return GestureDetector(
    onTap: () => ref.read(toggleIconsServicesViewProvider.notifier).toggle(),
    child: Container(
      padding: EdgeInsets.all(5.r.clamp(4.0, 6.0)),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        value ? Icons.short_text_rounded : Icons.apps_rounded,
        size: 14.r.clamp(12.0, 16.0),
        color: colorScheme.tertiary,
      ),
    ),
  );
}

Widget _buildServiceRow(
  BuildContext context,
  WidgetRef ref,
  MapEntry<String, String> entry,
) {
  final value = ref.watch(toggleIconsServicesViewProvider);
  final entryKeyCleaned = entry.key.replaceAll('_', ' ');
  final colorScheme = Theme.of(context).colorScheme;

  final icon = switch (entryKeyCleaned) {
    'prese 220V' => Icons.bolt_rounded,
    'bar' => Icons.local_cafe_rounded,
    'illuminazione notturna' => Icons.nightlight_round,
    'doccia calda' => Icons.hot_tub_rounded,
    'doccia fredda' => Icons.shower_rounded,
    _ => Icons.check_circle_outline_rounded,
  };

  final isAvailable = entry.value == 'si';

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.h),
    child: Row(
      children: [
        Container(
          width: 24.r.clamp(20.0, 28.0),
          height: 24.r.clamp(20.0, 28.0),
          decoration: BoxDecoration(
            color: isAvailable
                ? const Color(0xFF10B981).withValues(alpha: 0.1)
                : colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 14.r.clamp(12.0, 16.0),
            color: isAvailable
                ? const Color(0xFF10B981)
                : colorScheme.onSurface.withValues(alpha: 0.3),
          ),
        ),
        SizedBox(width: 8.w.clamp(6.0, 10.0)),
        Expanded(
          child: value
              ? const SizedBox.shrink()
              : Text(
                  _capitalizeFirst(entryKeyCleaned),
                  style: TextStyle(
                    fontSize: 10.sp.clamp(9.0, 11.0),
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
        Icon(
          isAvailable ? Icons.check_rounded : Icons.close_rounded,
          size: 14.r.clamp(12.0, 16.0),
          color: isAvailable
              ? const Color(0xFF10B981)
              : const Color(0xFFEF4444),
        ),
      ],
    ),
  );
}

String _capitalizeFirst(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
