import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDropdownButtonFormField(
  BuildContext context,
  String value,
  String labelText,
  List<String> items,
  Function(String) onChanged,
) {
  return Card(
    color:
        Theme.of(context).colorScheme.secondary, // same color as the ListTile
    margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
    elevation: 2.0, // same elevation as the Card
    child: Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: DropdownButtonFormField<String>(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        value: value,
        dropdownColor:
            Theme.of(context).colorScheme.secondary, // specify a color
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .onSecondary, // same color as the ListTile text
            fontWeight:
                FontWeight.bold, // same font weight as the ListTile text
          ),
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          onChanged(newValue!);
        },
      ),
    ),
  );
}
