import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'controller_utils.g.dart';

@riverpod
PanelController panelController(Ref ref) {
  return PanelController();
}

@riverpod
PopupController popupController(Ref ref) {
  return PopupController();
}
