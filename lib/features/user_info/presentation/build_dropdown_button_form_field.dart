import 'package:flutter/material.dart';

Widget buildDropdownButtonFormField(String value, String labelText,
    List<String> items, Function(String) onChanged) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: labelText,
    ),
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? newValue) {
      onChanged(newValue!);
    },
  );
}
