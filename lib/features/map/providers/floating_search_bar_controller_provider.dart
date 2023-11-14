import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'floating_search_bar_controller_provider.g.dart';

@riverpod
FloatingSearchBarController floatingSearchBarController(
  FloatingSearchBarControllerRef ref,
) {
  return FloatingSearchBarController();
}
