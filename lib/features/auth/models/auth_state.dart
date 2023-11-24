import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required final AuthResult? result,
    required final bool isLoading,
    required final UserId? userId,
  }) = _AuthState;

  // const factory AuthState.unknown() = _Unknown;
}
