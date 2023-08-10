import 'package:crosstrack_italia/states/auth/models/auth_result.dart';
import 'package:crosstrack_italia/states/auth/providers/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
