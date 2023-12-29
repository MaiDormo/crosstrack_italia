import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackInfoCard(
  Track trackSelected,
  BuildContext context,
) =>
    Expanded(
      child: Card(
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
                  color: Theme.of(context).primaryColor,
                ),
              ),
              buildAttributeRow(
                  Icons.military_tech, 'Categoria', trackSelected.category),
              buildAttributeRow(
                  Icons.gesture, 'Lunghezza', trackSelected.trackLength),
              buildAttributeRow(
                  Icons.terrain, 'Terreno', trackSelected.terrainType),
            ],
          ),
        ),
      ),
    );

Widget buildAttributeRow(
  IconData icon,
  String label,
  String value,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(
          width: 3.75.w,
        ),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.black,
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
