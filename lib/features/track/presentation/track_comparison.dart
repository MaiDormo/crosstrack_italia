import 'dart:math' as Math;

import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///TODO: remove if not used
// Card(
//   color: Colors.amber[200],
//   child: Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       children: [],
//     ),
//   ),
// ),

class TrackComparison extends StatelessWidget {
  final Track track1;
  final Track track2;
  final bool userLocationAvailable;
  final double userLatitude;
  final double userLongitude;

  TrackComparison({
    required this.track1,
    required this.track2,
    required this.userLocationAvailable,
    required this.userLatitude,
    required this.userLongitude,
  });

  @override
  Widget build(BuildContext context) {
    final columnWidth = MediaQuery.of(context).size.width / 2 - 24.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          title: Text(
            "Confronto tracciati",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          forceMaterialTransparency: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTextRow(track1.trackName, track2.trackName, columnWidth,
                    isTitle: true),

                // _buildComparisonImageRow(columnWidth),

                // Consumer(
                //   builder: (context, ref, child) {
                //     return _buildComparisonImageRow(columnWidth);
                //   },
                // ),

                _buildTitleSeparator("Motoclub"),
                _buildTextRow(track1.motoclub, track2.motoclub, columnWidth),

                _buildTitleSeparator("Posizione"),
                _buildComparisonRow(
                  "Regione",
                  track1.region,
                  track2.region,
                  false,
                  columnWidth,
                ),
                _buildComparisonRow(
                  "Città",
                  track1.location,
                  track2.location,
                  false,
                  columnWidth,
                ),
                _buildLocationComparisonRow(
                  track1.latitude,
                  track1.longitude,
                  track2.latitude,
                  track2.longitude,
                  columnWidth,
                ),

                _buildTitleSeparator("Caratteristiche"),
                _buildComparisonRow(
                  "Categoria",
                  track1.category,
                  track2.category,
                  false,
                  columnWidth,
                ),
                _buildComparisonRow(
                  "Lunghezza",
                  track1.trackLength,
                  track2.trackLength,
                  false,
                  columnWidth,
                ),
                _buildComparisonRow(
                  "Terreno",
                  track1.terrainType,
                  track2.terrainType,
                  false,
                  columnWidth,
                ),

                _buildTitleSeparator("Info Pilota"),
                _buildAcceptedLicensesRow(
                  track1.acceptedLicenses,
                  track2.acceptedLicenses,
                  columnWidth,
                ),

                //add track characteristics here
                _buildTitleSeparator("Servizi"),
                _buildServicesComparisonRow(
                  track1.services,
                  track2.services,
                  columnWidth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///TODO prova a ricontrollare il funzionamento di questo metodo se hai tempo
  Widget _buildComparisonImageRow(double columnWidth) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final tracksThumbnail =
            ref.watch(FetchSelectedTracksThumbnailProvider([track1, track2]));

        return tracksThumbnail.when(
          data: (images) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: columnWidth,
                  child: images[0],
                ),
                Container(
                  width: columnWidth,
                  child: images[1],
                ),
              ],
            );
          },
          loading: () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: columnWidth,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(
                  width: columnWidth,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
          error: (error, stackTrace) => Icon(Icons.error),
        );
      },
    );
  }

  Widget _buildComparisonRow(String label, String value1, String value2,
      bool compare, double columnWidth) {
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
                  ? (isValue1Better ? Colors.green : Colors.red)
                  : Colors.black,
              fontWeight: isValue1Better && compare
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
                  ? (isValue1Better ? Colors.red : Colors.green)
                  : Colors.black,
              fontWeight: !isValue1Better && compare
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextRow(String value1, String value2, double columnWidth,
      {bool isTitle = false}) {
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesComparisonRow(Map<String, String>? services1,
      Map<String, String>? services2, double columnWidth) {
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

  Widget _buildLocationComparisonRow(String latitude1, String longitude1,
      String latitude2, String longitude2, double columnWidth) {
    if (userLocationAvailable) {
      final double distance1 = _calculateDistance(userLatitude, userLongitude,
          double.parse(latitude1), double.parse(longitude1));
      final double distance2 = _calculateDistance(userLatitude, userLongitude,
          double.parse(latitude2), double.parse(longitude2));

      return _buildComparisonRow(
        "Distanza Aerea",
        "${distance1.toStringAsFixed(2)} km",
        "${distance2.toStringAsFixed(2)} km",
        true,
        columnWidth,
      );
    } else {
      return Container(); // User location not available, skip distance comparison
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
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2.0),
            child,
            const SizedBox(height: 8.0),
          ],
        ),
      );

  Widget _buildTitleSeparator(String text) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4.0),
          Divider(
            color: Colors.blueAccent,
            thickness: 1.0,
          ),
          const SizedBox(height: 8.0),
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
