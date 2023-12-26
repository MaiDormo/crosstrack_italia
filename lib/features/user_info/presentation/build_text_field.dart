import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  int? maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
    ),
    keyboardType: keyboardType,
    validator: validator,
    maxLines: maxLines,
  );
}
