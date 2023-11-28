import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildMotoclubCard(
        Track selectedTrack, BuildContext context, double heightFactor) =>
    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '${selectedTrack.motoclub}',
                style: TextStyle(
                  fontSize: 15 * heightFactor,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 4 * heightFactor,
              ),
              SvgPicture.asset(
                'assets/svgs/f_logo.svg',
                height: 50 * heightFactor,
                colorFilter: ColorFilter.mode(
                  Colors.blueAccent,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
