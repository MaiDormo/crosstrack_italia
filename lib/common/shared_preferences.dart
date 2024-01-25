// providers.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod/riverpod.dart';

//this provider starts as a throw error provider,
//but it is overridden in the main.dart file

//this was suggested by the riverpod documentation
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
