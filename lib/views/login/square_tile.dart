import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });
  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20).h,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              imagePath.contains('f') ? 'Facebook' : 'Google',
              style: TextStyle(
                fontSize: 15.sp,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            SizedBox(width: 5.w),
            SvgPicture.asset(
              imagePath,
              height: 30.h,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSecondary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
