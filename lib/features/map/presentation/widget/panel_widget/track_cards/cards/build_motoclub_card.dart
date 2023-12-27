import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget buildMotoclubCard(
  Track selectedTrack,
  BuildContext context,
) =>
    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '${selectedTrack.motoclub}',
                style: TextStyle(
                  fontSize: 11.25.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              3.verticalSpace,
              SvgPicture.asset(
                'assets/svgs/f_logo.svg',
                height: 37.5.h,
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
