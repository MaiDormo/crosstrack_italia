import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  int? maxLines = 1,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
    color:
        Theme.of(context).colorScheme.secondary, // same color as the ListTile
    elevation: 2.0, // same elevation as the Card
    child: Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Colors.blueGrey,
        validator: validator,
        maxLines: maxLines, // specify a color
        style: const TextStyle(
          // adjust the font size
          color: Colors.white,
          fontWeight: FontWeight.bold, // adjust the text color
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade300, // same color as the ListTile text
            fontWeight:
                FontWeight.bold, // same font weight as the ListTile text
          ), // add a border to the TextField
          fillColor: Colors.white, // add a fill color to the TextField
        ),
      ),
    ),
  );
}
