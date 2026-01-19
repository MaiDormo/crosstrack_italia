import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/responsive.dart';
import '../models/track.dart';
import '../models/typedefs/typedefs.dart';

class TrackComparison extends StatelessWidget {

  const TrackComparison({super.key, 
    required this.track1,
    required this.track2,
    required this.userLocationAvailable,
    required this.userLocation,
  });
  
  final Track track1;
  final Track track2;
  final bool userLocationAvailable;
  final Position? userLocation;

  @override
  Widget build(BuildContext context) {
    // Responsive column width - use percentage of screen width
    final screenWidth = Responsive.screenWidth(context);
    final columnWidth = Responsive.value(
      context,
      mobile: (screenWidth * 0.42).clamp(120.0, 200.0),
      tablet: (screenWidth * 0.35).clamp(200.0, 300.0),
      desktop: (screenWidth * 0.3).clamp(250.0, 400.0),
    );
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Confronto tracciati',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back, color: colorScheme.primary, size: 20.r),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ResponsiveContainer(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: Responsive.padding(context),
              child: Column(
                children: [
                  // Track names header card
                  _buildHeaderCard(context, track1.trackName, track2.trackName, columnWidth),

                  16.verticalSpace,

                  // Motoclub section
                  _buildSectionCard(
                    context,
                    'Motoclub',
                    Icons.sports_motorsports_rounded,
                    [
                      _buildTextRow(context, track1.motoclub, track2.motoclub, columnWidth),
                    ],
                  ),

                  12.verticalSpace,

                  // Location section
                  _buildSectionCard(
                    context,
                    'Posizione',
                    Icons.location_on_rounded,
                    [
                      _buildComparisonRow('Regione', track1.region, track2.region, false, columnWidth, context),
                      _buildComparisonRow('Città', track1.location, track2.location, false, columnWidth, context),
                      _buildLocationComparisonRow(
                        track1.latitude, track1.longitude,
                        track2.latitude, track2.longitude,
                        columnWidth, context,
                      ),
                    ],
                  ),

                  12.verticalSpace,

                  // Characteristics section
                  _buildSectionCard(
                    context,
                    'Caratteristiche',
                    Icons.tune_rounded,
                    [
                      _buildComparisonRow('Categoria', track1.category, track2.category, false, columnWidth, context),
                      _buildComparisonRow('Lunghezza', track1.trackLength, track2.trackLength, false, columnWidth, context),
                      _buildComparisonRow('Terreno', track1.terrainType, track2.terrainType, false, columnWidth, context),
                    ],
                  ),

                  12.verticalSpace,

                  // Licenses section
                  if (track1.acceptedLicenses.isNotEmpty && track2.acceptedLicenses.isNotEmpty)
                    _buildSectionCard(
                      context,
                      'Info Pilota',
                      Icons.badge_rounded,
                      [
                        _buildAcceptedLicensesRow(track1.acceptedLicenses, track2.acceptedLicenses, columnWidth, context),
                      ],
                    ),

                  12.verticalSpace,

                  // Services section
                  if (track1.services != null && track2.services != null &&
                      track1.services!.isNotEmpty && track2.services!.isNotEmpty)
                    _buildSectionCard(
                      context,
                      'Servizi',
                      Icons.room_service_rounded,
                      [
                        _buildServicesComparisonRow(track1.services, track2.services, columnWidth, context),
                      ],
                    ),

                  24.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, String name1, String name2, double columnWidth) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Icon(Icons.flag_rounded, color: colorScheme.onPrimary.withValues(alpha: 0.8), size: 24.r),
                8.verticalSpace,
                Text(
                  name1,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'VS',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: colorScheme.onSecondary,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.flag_rounded, color: colorScheme.onPrimary.withValues(alpha: 0.8), size: 24.r),
                8.verticalSpace,
                Text(
                  name2,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, IconData icon, List<Widget> children) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.secondary.withValues(alpha: 0.2),
                      colorScheme.secondary.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colorScheme.secondary, size: 20.r),
              ),
              12.horizontalSpace,
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          ...children,
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String value1, String value2,
      bool compare, double columnWidth, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isValue1Better = _isValue1Better(value1, value2);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: compare && isValue1Better
                        ? colorScheme.secondary.withValues(alpha: 0.1)
                        : colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: compare && isValue1Better
                          ? colorScheme.secondary.withValues(alpha: 0.3)
                          : colorScheme.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    value1,
                    style: GoogleFonts.poppins(
                      color: compare && isValue1Better
                          ? colorScheme.secondary
                          : colorScheme.onSurface,
                      fontWeight: compare && isValue1Better
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: compare && !isValue1Better
                        ? colorScheme.secondary.withValues(alpha: 0.1)
                        : colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: compare && !isValue1Better
                          ? colorScheme.secondary.withValues(alpha: 0.3)
                          : colorScheme.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    value2,
                    style: GoogleFonts.poppins(
                      color: compare && !isValue1Better
                          ? colorScheme.secondary
                          : colorScheme.onSurface,
                      fontWeight: compare && !isValue1Better
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextRow(
    BuildContext context,
    String value1,
    String value2,
    double columnWidth,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value1,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value2,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesComparisonRow(
      Map<String, String>? services1,
      Map<String, String>? services2,
      double columnWidth,
      BuildContext context) {
    if (services1 == null ||
        services2 == null ||
        services1.isEmpty ||
        services2.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ...services1.entries.map((e) {
          final String key = e.key.replaceAll('_', ' ');
          final String value1 = e.value;
          final String value2 = (services2[e.key] ?? '');

          return _buildComparisonRow(
            key,
            value1,
            value2,
            false,
            columnWidth,
            context,
          );
        }),
      ],
    );
  }

  Widget _buildAcceptedLicensesRow(List<TrackLicense> licenses1,
      List<TrackLicense> licenses2, double columnWidth, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Licenze accettate',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          8.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: licenses1.map((license) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      license.toString().split('.').last,
                      style: GoogleFonts.poppins(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                      ),
                    ),
                  )).toList(),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: licenses2.map((license) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      license.toString().split('.').last,
                      style: GoogleFonts.poppins(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationComparisonRow(
      String latitude1,
      String longitude1,
      String latitude2,
      String longitude2,
      double columnWidth,
      BuildContext context) {
    if (userLocationAvailable && userLocation != null) {
      final double distance1 = _calculateDistance(
        userLocation!.latitude,
        userLocation!.longitude,
        double.parse(latitude1),
        double.parse(longitude1),
      );

      final double distance2 = _calculateDistance(
        userLocation!.latitude,
        userLocation!.longitude,
        double.parse(latitude2),
        double.parse(longitude2),
      );

      // Determine which is closer
      final bool track1Closer = distance1 < distance2;

      return _buildComparisonRow(
        'Distanza Aerea',
        '${distance1.toStringAsFixed(2)} km',
        '${distance2.toStringAsFixed(2)} km',
        true,
        columnWidth,
        context,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  bool _isValue1Better(String value1, String value2) {
    if (value1.isEmpty || value2.isEmpty) {
      return false;
    }

    // For distance comparisons, lower is better
    if (value1.contains('km') && value2.contains('km')) {
      try {
        final d1 = double.parse(value1.replaceAll(RegExp(r'[^0-9.]'), ''));
        final d2 = double.parse(value2.replaceAll(RegExp(r'[^0-9.]'), ''));
        return d1 < d2;
      } catch (e) {
        return false;
      }
    }

    return value1 == 'si' && value2 == 'no';
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double radius = 6371.0; // Earth radius in kilometers

    double toRadians(double degree) {
      return degree * (3.141592653589793238462643383279 / 180.0);
    }

    double dLat = toRadians(lat2 - lat1);
    double dLon = toRadians(lon2 - lon1);

    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(toRadians(lat1)) *
            Math.cos(toRadians(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);

    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return radius * c;
  }
}
