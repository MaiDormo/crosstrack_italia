import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../track/models/track.dart';

Widget buildTrackInfoCard(
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
      child: Column(
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
                  Icons.info_outline_rounded,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Info Tracciato',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _buildAttributeRow(
            Icons.military_tech_rounded,
            'Categoria',
            trackSelected.category,
            context,
          ),
          SizedBox(height: 10.h),
          _buildAttributeRow(
            Icons.straighten_rounded,
            'Lunghezza',
            trackSelected.trackLength,
            context,
          ),
          SizedBox(height: 10.h),
          _buildAttributeRow(
            Icons.terrain_rounded,
            'Terreno',
            trackSelected.terrainType,
            context,
          ),
        ],
      ),
    ),
  );
}

Widget _buildAttributeRow(
  IconData icon,
  String label,
  String value,
  BuildContext context,
) {
  final colorScheme = Theme.of(context).colorScheme;
  
  return Row(
    children: [
      Icon(
        icon,
        size: 16.r,
        color: colorScheme.tertiary,
      ),
      SizedBox(width: 8.w),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: colorScheme.tertiary,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
