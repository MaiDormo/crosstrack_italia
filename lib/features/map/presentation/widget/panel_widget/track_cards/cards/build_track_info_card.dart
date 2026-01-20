import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../track/models/track.dart';

Widget buildTrackInfoCard(Track trackSelected, BuildContext context) {
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
      child: Column(
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
                  Icons.info_outline_rounded,
                  size: 16.r.clamp(14.0, 18.0),
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.w.clamp(6.0, 10.0)),
              Expanded(
                child: Text(
                  'Info',
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12.0, 14.0),
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildAttributeRow(
            Icons.military_tech_rounded,
            'Cat.',
            trackSelected.category,
            context,
          ),
          SizedBox(height: 8.h),
          _buildAttributeRow(
            Icons.straighten_rounded,
            'Lung.',
            trackSelected.trackLength,
            context,
          ),
          SizedBox(height: 8.h),
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
      Icon(icon, size: 14.r.clamp(12.0, 16.0), color: colorScheme.tertiary),
      SizedBox(width: 6.w.clamp(4.0, 8.0)),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp.clamp(10.0, 12.0),
                color: colorScheme.tertiary,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 11.sp.clamp(10.0, 12.0),
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
