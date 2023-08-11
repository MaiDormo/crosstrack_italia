import 'package:crosstrack_italia/views/components/rich_text/base_text.dart';
import 'package:crosstrack_italia/views/components/rich_text/link_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (baseText) {
            if (baseText is LinkText) {
              //baseText variable is promoted to linktext
              //this would not work with a boolean getter
              return TextSpan(
                text: baseText.text,
                //if texts contains a style has a priority over styleForAll
                //this means that the style and the text will get merged
                style: styleForAll?.merge(baseText.style),
                recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
              );
            } else {
              //this is going to be BaseText
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
              );
            }
          },
        ).toList(),
      ),
    );
  }
}
