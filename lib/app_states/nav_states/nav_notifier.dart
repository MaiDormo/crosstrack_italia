import 'package:crosstrack_italia/app_states/nav_states/nav_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavNotifier extends StateNotifier<NavStates> {
  NavNotifier() : super(const NavStates());

  void onIndexChanged(int index) => state = state.copyWith(index: index);
}

//this is the provider that will be used to call the notifier from the UI
//and update the state of the app accordingly
final navProvider =
    StateNotifierProvider<NavNotifier, NavStates>((ref) => NavNotifier());
