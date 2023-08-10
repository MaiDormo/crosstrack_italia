import 'package:crosstrack_italia/states/auth/providers/auth_state_provider.dart';
import 'package:crosstrack_italia/states/posts/typedefs/user_id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStateProvider).userId);
