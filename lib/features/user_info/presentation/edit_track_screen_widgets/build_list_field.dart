import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildListField({
  required BuildContext context,
  required List<String> items,
  required String labelText,
  required Widget Function(BuildContext, int) itemBuilder,
  TextEditingController? controller,
}) {
  return Card(
    elevation: 2.0,
    color: Theme.of(context).colorScheme.secondary,
    margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: itemBuilder,
    ),
  );
}
