import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPilotInfoCard(
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
                  Icons.badge_outlined,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Info Pilota',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Licenses
          Text(
            'Licenze accettate',
            style: TextStyle(
              fontSize: 11.sp,
              color: colorScheme.tertiary,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: trackSelected.acceptedLicenses
                .map((license) => _buildLicenseChip(license, context))
                .toList(),
          ),
          SizedBox(height: 14.h),
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
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
    decoration: BoxDecoration(
      color: colorScheme.primary.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            'assets/images/license_img/logo-${license.toString().split('.').last}.jpg',
            height: 18.r,
            width: 18.r,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.verified_rounded,
              size: 16.r,
              color: colorScheme.primary,
            ),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          licenseName,
          style: TextStyle(
            fontSize: 11.sp,
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
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: isAvailable 
          ? const Color(0xFF10B981).withValues(alpha: 0.1)
          : colorScheme.onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(
          Icons.child_care_rounded,
          size: 20.r,
          color: isAvailable 
              ? const Color(0xFF10B981)
              : colorScheme.onSurface.withValues(alpha: 0.4),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            'Minicross',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isAvailable 
                ? const Color(0xFF10B981)
                : const Color(0xFFEF4444),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            isAvailable ? 'Sì' : 'No',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
