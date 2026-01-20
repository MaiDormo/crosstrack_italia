import '../../../features/map/presentation/widget/geolocation_button.dart';
import '../../../features/map/presentation/widget/location_text.dart';
import 'login_icon.dart';
import 'login_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.0.w,
        right: 8.0.w,
        top: 8.0.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const GeolocationButton(),
                  Flexible(
                    child: Text(
                      'Cross Track Italia',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const loginIcon(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: LocationText()),
                    loginIconText(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
