import 'dart:math' as Math;

import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class TrackComparison extends StatelessWidget {
  final Track track1;
  final Track track2;
  final bool userLocationAvailable;
  final Position? userLocation;

  TrackComparison({
    required this.track1,
    required this.track2,
    required this.userLocationAvailable,
    required this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    final columnWidth = 181.7.w;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            "Confronto tracciati",
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          forceMaterialTransparency: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: Column(
              children: [
                _buildTextRow(
                    context, track1.trackName, track2.trackName, columnWidth,
                    isTitle: true),

                30.verticalSpace,

                _buildTitleSeparator("Motoclub", context),
                _buildTextRow(
                    context, track1.motoclub, track2.motoclub, columnWidth),

                10.verticalSpace,

                _buildTitleSeparator("Posizione", context),
                _buildComparisonRow(
                  "Regione",
                  track1.region,
                  track2.region,
                  false,
                  columnWidth,
                  context,
                ),

                _buildComparisonRow(
                  "Città",
                  track1.location,
                  track2.location,
                  false,
                  columnWidth,
                  context,
                ),

                _buildLocationComparisonRow(
                  track1.latitude,
                  track1.longitude,
                  track2.latitude,
                  track2.longitude,
                  columnWidth,
                  context,
                ),

                10.verticalSpace,

                _buildTitleSeparator("Caratteristiche", context),
                _buildComparisonRow(
                  "Categoria",
                  track1.category,
                  track2.category,
                  false,
                  columnWidth,
                  context,
                ),
                _buildComparisonRow(
                  "Lunghezza",
                  track1.trackLength,
                  track2.trackLength,
                  false,
                  columnWidth,
                  context,
                ),
                _buildComparisonRow(
                  "Terreno",
                  track1.terrainType,
                  track2.terrainType,
                  false,
                  columnWidth,
                  context,
                ),

                10.verticalSpace,

                _buildTitleSeparator("Info Pilota", context),
                _buildAcceptedLicensesRow(
                  track1.acceptedLicenses,
                  track2.acceptedLicenses,
                  columnWidth,
                ),

                10.verticalSpace,

                //add track characteristics here
                _buildTitleSeparator("Servizi", context),
                _buildServicesComparisonRow(
                  track1.services,
                  track2.services,
                  columnWidth,
                  context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String label, String value1, String value2,
      bool compare, double columnWidth, BuildContext context) {
    final bool isValue1Better = _isValue1Better(value1, value2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSubCategoryColumn(
          label,
          columnWidth,
          child: Text(
            "$value1",
            style: TextStyle(
              color: compare
                  ? (isValue1Better
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context)
                          .colorScheme
                          .primary) // Use secondary and error colors from theme
                  : Theme.of(context)
                      .colorScheme
                      .onSurface, // Use onSurface color from theme
              fontWeight: !isValue1Better && compare
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
        _buildSubCategoryColumn(
          label,
          columnWidth,
          child: Text(
            "$value2",
            style: TextStyle(
              color: compare
                  ? (isValue1Better
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context)
                          .colorScheme
                          .primary) // Use error and secondary colors from theme
                  : Theme.of(context)
                      .colorScheme
                      .onSurface, // Use onSurface color from theme
              fontWeight: isValue1Better && compare
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextRow(
    BuildContext context,
    String value1,
    String value2,
    double columnWidth, {
    bool isTitle = false,
  }) {
    final textSize = isTitle ? 16.0 : 14.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: columnWidth,
          child: Text(
            value1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: textSize,
              color: isTitle
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.black, // Use primary color from theme
            ),
          ),
        ),
        Container(
          width: columnWidth,
          child: Text(
            value2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: textSize,
              color: isTitle
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.black, // Use primary color from theme
            ),
          ),
        ),
      ],
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
      return Container();
    }

    return Column(
      children: [
        ...services1.entries.map((e) {
          final String key = e.key.replaceAll('_', ' ');
          final String value1 = e.value;
          final String value2 = (services2[e.key] ?? "");

          return _buildComparisonRow(
            key,
            value1,
            value2,
            false,
            columnWidth,
            context,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAcceptedLicensesRow(
      List<String> licenses1, List<String> licenses2, double columnWidth) {
    if (licenses1.isEmpty || licenses2.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSubCategoryColumn(
              "Licenze",
              columnWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...licenses2.map(
                    (value) => Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSubCategoryColumn(
              "Licenze",
              columnWidth,
              child: Column(
                children: [
                  ...licenses1.map(
                    (value) => Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationComparisonRow(
      String latitude1,
      String longitude1,
      String latitude2,
      String longitude2,
      double columnWidth,
      BuildContext context) {
    print(
        'DEBUG - userLocationAvailable: $userLocationAvailable, userLocation: $userLocation');
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

      print('DEBUG - Distance 1: $distance1, Distance 2: $distance2');

      return _buildComparisonRow(
        "Distanza Aerea",
        "${distance1.toStringAsFixed(2)} km",
        "${distance2.toStringAsFixed(2)} km",
        true,
        columnWidth,
        context,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildSubCategoryColumn(String text, double columnWidth,
          {required Widget child}) =>
      Container(
        width: columnWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0.sp,
                color: Colors.black,
              ),
            ),
            2.verticalSpace,
            child,
            8.verticalSpace,
          ],
        ),
      );

  Widget _buildTitleSeparator(String text, BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0.sp,
              color: Theme.of(context)
                  .colorScheme
                  .error, // Use primary color from theme
            ),
          ),
          4.verticalSpace,
          Divider(
            color: Theme.of(context)
                .colorScheme
                .primaryContainer, // Use primary variant color from theme
            thickness: 1.0,
          ),
          8.verticalSpace,
        ],
      );

  bool _isValue1Better(String value1, String value2) {
    if (value1.isEmpty || value2.isEmpty) {
      return false;
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
