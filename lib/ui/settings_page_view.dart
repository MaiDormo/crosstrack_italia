import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/dialogs/logout_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import '../states/auth/providers/auth_state_provider.dart';

class SettingsPageView extends ConsumerWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final shouldLogOut = await const LogoutDialog()
                .present(context)
                .then((value) => value ?? false);
            if (shouldLogOut) {
              await ref.read(authStateProvider.notifier).logOut();
            }
          },
          child: const Text(
            'Sign out',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
