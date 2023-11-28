import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';

Widget buildTrackInfoCard(
        Track trackSelected, BuildContext context, double heightFactor) =>
    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Infomazioni Tracciato',
                style: TextStyle(
                  fontSize: 15 * heightFactor,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              buildAttributeRow(Icons.military_tech, 'Categoria',
                  trackSelected.category, heightFactor),
              buildAttributeRow(
                Icons.gesture,
                'Lunghezza',
                trackSelected.trackLength,
                heightFactor,
              ),
              buildAttributeRow(
                Icons.terrain,
                'Terreno',
                trackSelected.terrainType,
                heightFactor,
              ),
            ],
          ),
        ),
      ),
    );

Widget buildAttributeRow(
        IconData icon, String label, String value, double heightFactor) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(
          width: 4 * heightFactor,
        ),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15 * heightFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 4 * heightFactor,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15 * heightFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
