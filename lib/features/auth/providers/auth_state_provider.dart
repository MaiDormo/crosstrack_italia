import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show StateNotifierProvider;

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);
