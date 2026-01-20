import 'nav_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nav_notifier.g.dart';

@riverpod
class NavNotifier extends _$NavNotifier {
  @override
  NavStates build() {
    return const NavStates();
  }

  void onIndexChanged(int index) => state = state.copyWith(index: index);
}
