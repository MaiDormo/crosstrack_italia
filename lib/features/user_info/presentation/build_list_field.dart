import 'package:flutter/material.dart';

Widget buildListField({
  required List<String> items,
  required String labelText,
  required Widget Function(BuildContext, int) itemBuilder,
  TextEditingController? controller,
}) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: items.length,
    itemBuilder: itemBuilder,
  );
}
