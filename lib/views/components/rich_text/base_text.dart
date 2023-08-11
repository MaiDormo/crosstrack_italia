import 'package:crosstrack_italia/views/components/rich_text/link_text.dart';
import 'package:flutter/material.dart' show Colors, TextDecoration, TextStyle;

import 'package:flutter/foundation.dart' show immutable, VoidCallback;

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  //factory constructor for plain text
  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  //factory constructor for link
  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.orange,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        onTapped: onTapped,
        style: style,
      );

  //In this class is shown how a class is able to return
  // a instance of its subclass (that can itself add more
  // functionality to the super class).
  //Apple calls it 'Class Clustering'.
}
