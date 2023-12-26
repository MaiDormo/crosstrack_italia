import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen_widgets/build_text_field.dart';
import 'package:flutter/material.dart';

Widget buildLengthField({
  required TextEditingController lengthController,
}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: buildTextField(
          controller: lengthController,
          labelText: 'Length',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a length';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text('m'),
      ),
    ],
  );
}
