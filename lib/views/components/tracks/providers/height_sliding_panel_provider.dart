import 'package:hooks_riverpod/hooks_riverpod.dart';

final heightSlidingPanelProvider =
    StateProvider.autoDispose<double>((ref) => 0);
