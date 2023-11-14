import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'panel_controller_provider.g.dart';

@riverpod
PanelController panelController(PanelControllerRef ref) {
  return PanelController();
}

//Previously:
// final panelControllerProvider =
//     StateProvider.autoDispose<PanelController>((ref) {
//   return PanelController();
// });
