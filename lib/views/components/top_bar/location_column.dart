import 'package:crosstrack_italia/features/map/presentation/widget/geolocation_button.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/location_text.dart';
import 'package:flutter/material.dart';

class LocationColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Posizione Attuale:',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.03,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Row(
          children: [
            GeolocationButton(),
            LocationText(),
          ],
        )
      ],
    );
  }
}
