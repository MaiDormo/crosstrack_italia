import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final panelControllerProvider =
    StateProvider.autoDispose<PanelController>((ref) {
  return PanelController();
});
