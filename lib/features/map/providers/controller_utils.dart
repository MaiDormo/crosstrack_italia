import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'controller_utils.g.dart';

@riverpod
FloatingSearchBarController floatingSearchBarController(
  FloatingSearchBarControllerRef ref,
) {
  return FloatingSearchBarController();
}

@riverpod
PanelController panelController(PanelControllerRef ref) {
  return PanelController();
}

@riverpod
PopupController popupController(PopupControllerRef ref) {
  return PopupController();
}
