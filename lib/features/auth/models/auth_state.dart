import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required final AuthResult? result,
    required final User? user,
  }) = _AuthState;
}
