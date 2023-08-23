import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_current_location_provider.g.dart';

@riverpod
class ShowCurrentLocation extends _$ShowCurrentLocation {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}
