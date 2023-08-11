import 'package:crosstrack_italia/views/components/rich_text/base_text.dart';
import 'package:flutter/foundation.dart' show immutable, VoidCallback;

@immutable
class LinkText extends BaseText {
  //in order to let the text know wich void callback to make
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}
