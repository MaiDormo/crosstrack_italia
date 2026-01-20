import '../../../../../../track/models/track.dart';
import '../../../../../../track/models/typedefs/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPilotInfoCard(Track trackSelected, BuildContext context) {
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
                  Icons.badge_outlined,
                  size: 16.r.clamp(14.0, 18.0),
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.w.clamp(6.0, 10.0)),
              Expanded(
                child: Text(
                  'Pilota',
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12.0, 14.0),
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Licenses
          Text(
            'Licenze',
            style: TextStyle(
              fontSize: 10.sp.clamp(9.0, 11.0),
              color: colorScheme.tertiary,
            ),
          ),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: trackSelected.acceptedLicenses
                .map((license) => _buildLicenseChip(license, context))
                .toList(),
          ),
          SizedBox(height: 10.h),
          // Minicross
          _buildMinicrossRow(trackSelected.hasMinicross, context),
        ],
      ),
    ),
  );
}

Widget _buildLicenseChip(TrackLicense license, BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final licenseName = license.toString().split('.').last.toUpperCase();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: colorScheme.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Image.asset(
            'assets/images/license_img/logo-${license.toString().split('.').last}.jpg',
            height: 14.r.clamp(12.0, 16.0),
            width: 14.r.clamp(12.0, 16.0),
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.verified_rounded,
              size: 12.r.clamp(10.0, 14.0),
              color: colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          licenseName,
          style: TextStyle(
            fontSize: 10.sp.clamp(9.0, 11.0),
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMinicrossRow(String value, BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final isAvailable = value == 'si';

  return Container(
    padding: EdgeInsets.all(10.r.clamp(8.0, 12.0)),
    decoration: BoxDecoration(
      color: isAvailable
          ? const Color(0xFF10B981).withValues(alpha: 0.1)
          : colorScheme.onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(
          Icons.child_care_rounded,
          size: 18.r.clamp(16.0, 20.0),
          color: isAvailable
              ? const Color(0xFF10B981)
              : colorScheme.onSurface.withValues(alpha: 0.4),
        ),
        SizedBox(width: 8.w.clamp(6.0, 10.0)),
        Expanded(
          child: Text(
            'Mini',
            style: TextStyle(
              fontSize: 12.sp.clamp(11.0, 13.0),
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: isAvailable
                ? const Color(0xFF10B981)
                : const Color(0xFFEF4444),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            isAvailable ? 'Sì' : 'No',
            style: TextStyle(
              fontSize: 10.sp.clamp(9.0, 11.0),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
