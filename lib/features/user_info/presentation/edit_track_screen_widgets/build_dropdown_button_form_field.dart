import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDropdownButtonFormField(
  String value,
  String labelText,
  List<String> items,
  Function(String) onChanged,
) {
  return Card(
    color: Color.fromRGBO(50, 65, 85, 0.9), // same color as the ListTile
    margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
    elevation: 2.0, // same elevation as the Card
    child: Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: Colors.blueGrey, // specify a color
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white, // same color as the ListTile text
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
                color: Colors.grey.shade300,
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
