import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackInfoCard(
  Track trackSelected,
  BuildContext context,
) =>
    Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.all(8.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Infomazioni Tracciato',
                style: TextStyle(
                  fontSize: 11.25.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              buildAttributeRow(Icons.military_tech, 'Categoria',
                  trackSelected.category, context),
              buildAttributeRow(Icons.gesture, 'Lunghezza',
                  trackSelected.trackLength, context),
              buildAttributeRow(
                  Icons.terrain, 'Terreno', trackSelected.terrainType, context),
            ],
          ),
        ),
      ),
    );

Widget buildAttributeRow(
  IconData icon,
  String label,
  String value,
  BuildContext context,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        SizedBox(
          width: 3.75.w,
        ),
        Text(
          '$label: ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 11.25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        3.verticalSpace,
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.25.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
