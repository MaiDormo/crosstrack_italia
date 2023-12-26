import 'package:crosstrack_italia/views/components/bottom_bar/nav_states/nav_states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nav_notifier.g.dart';

// class NavNotifier extends StateNotifier<NavStates> {
//   NavNotifier() : super(const NavStates());

//   void onIndexChanged(int index) => state = state.copyWith(index: index);
// }

@riverpod
class NavNotifier extends _$NavNotifier {
  @override
  NavStates build() {
    return const NavStates();
  }

  void onIndexChanged(int index) => state = state.copyWith(index: index);
}
