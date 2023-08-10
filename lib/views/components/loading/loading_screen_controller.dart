import 'package:flutter/foundation.dart' show immutable;

typedef ClosedLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

//two main functions:
//  1. is for the loading screen to get close
//  2. is in order to get updated with new text
@immutable
class LoadingScreenController {
  final ClosedLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
