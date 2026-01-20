import '../constants/user_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_settings.g.dart';

@riverpod
class UserSettings extends _$UserSettings {
  @override
  Map<String, bool> build() => {
        UserConstants.permanentTextBottomBar: true,
        UserConstants.showMoreInfo: true,
        UserConstants.showSettingsInDevelopment: false,
        UserConstants.showLocationTopBar: true,
      };

  void updateSettings(String key, bool value) {
    state = {...state, key: value};
  }
}
