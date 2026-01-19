import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildServicesCard(
  Track trackSelected,
  BuildContext context,
) {
  final colorScheme = Theme.of(context).colorScheme;
  
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(16.r),
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
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.build_circle_outlined,
                      size: 18.r,
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Servizi',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  _buildViewToggle(context, ref),
                ],
              ),
              SizedBox(height: 12.h),
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
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        value ? Icons.short_text_rounded : Icons.apps_rounded,
        size: 16.r,
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
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      children: [
        Container(
          width: 28.r,
          height: 28.r,
          decoration: BoxDecoration(
            color: isAvailable 
                ? const Color(0xFF10B981).withValues(alpha: 0.1)
                : colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16.r,
            color: isAvailable 
                ? const Color(0xFF10B981)
                : colorScheme.onSurface.withValues(alpha: 0.3),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: value
              ? const SizedBox.shrink()
              : Text(
                  _capitalizeFirst(entryKeyCleaned),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
        ),
        Icon(
          isAvailable ? Icons.check_rounded : Icons.close_rounded,
          size: 16.r,
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
