import 'package:crosstrack_italia/features/map/presentation/widget/geolocation_button.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/location_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Posizione Attuale:',
          style: TextStyle(
            fontSize: 12.3.sp,
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
