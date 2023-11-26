import 'dart:math' as Math;

import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Confronto tracciati"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTrackColumn(track1, "Tracciato 1", screenWidth),
              _buildTrackColumn(track2, "Tracciato 2", screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackColumn(Track track, String trackTitle, double screenWidth) {
    final columnWidth = screenWidth > 600 ? screenWidth / 2 : screenWidth;

    return Container(
      width: columnWidth,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trackTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          _buildRow("Region", track.region),
          _buildRow("Location", track.location),
          _buildRow("Motoclub", track.motoclub),
          _buildComparisonRow(
              "Category", track1.category, track2.category, true),
          _buildComparisonRow(
              "Track Length", track1.trackLength, track2.trackLength, true),
          _buildRow("Licenses", track.acceptedLicenses.join(", "),
              isSubtitle: true),
          _buildRow("Terrain Type", track.terrainType, isSubtitle: true),
          _buildComparisonRow(
              "Has Minicross", track1.hasMinicross, track2.hasMinicross, true),
          _buildServicesComparisonRow(track.services),
          _buildLocationComparisonRow(track1.latitude, track1.longitude,
              track2.latitude, track2.longitude),
          _buildComparisonRow("Comment Count", track1.commentCount.toString(),
              track2.commentCount.toString(), true),
          _buildComparisonRow("Rating", track1.rating.toString(),
              track2.rating.toString(), true),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isSubtitle = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "$label: $value",
        style: TextStyle(
          color: isSubtitle ? Colors.grey : Colors.black,
          fontSize: isSubtitle ? 14.0 : 16.0,
          fontWeight: isSubtitle ? FontWeight.normal : FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildComparisonRow(
      String label, String value1, String value2, bool compare) {
    final bool isValue1Better = compare && _isValue1Better(value1, value2);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label: $value1",
            style: TextStyle(
              color: isValue1Better ? Colors.green : Colors.red,
              fontWeight: isValue1Better ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            "$value2",
            style: TextStyle(
              color: isValue1Better ? Colors.red : Colors.green,
              fontWeight: isValue1Better ? FontWeight.normal : FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesComparisonRow(Map<String, String>? services) {
    if (services == null || services.isEmpty) {
      return Container(); // No services to display
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: services.entries.map((entry) {
        return _buildComparisonRow(entry.key, entry.value, entry.value, true);
      }).toList(),
    );
  }

  Widget _buildLocationComparisonRow(String latitude1, String longitude1,
      String latitude2, String longitude2) {
    if (userLocationAvailable) {
      final double distance1 = _calculateDistance(userLatitude, userLongitude,
          double.parse(latitude1), double.parse(longitude1));
      final double distance2 = _calculateDistance(userLatitude, userLongitude,
          double.parse(latitude2), double.parse(longitude2));

      return _buildComparisonRow(
          "Distance",
          "${distance1.toStringAsFixed(2)} km",
          "${distance2.toStringAsFixed(2)} km",
          true);
    } else {
      return Container(); // User location not available, skip distance comparison
    }
  }

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
