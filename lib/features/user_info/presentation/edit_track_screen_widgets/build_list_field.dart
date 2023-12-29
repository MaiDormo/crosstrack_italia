import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildListField({
  required List<String> items,
  required String labelText,
  required Widget Function(BuildContext, int) itemBuilder,
  TextEditingController? controller,
}) {
  return Card(
    elevation: 2.0,
    color: Color.fromRGBO(50, 65, 85, 0.9),
    margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
    child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: itemBuilder,
    ),
  );
}
