import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/user_info/track_owner/presentation/track_ownership_stepper.dart';
import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPageView extends ConsumerWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> shouldLogOut(BuildContext context) async {
      final shouldLogOut = await const LogoutDialog()
          .present(context)
          .then((value) => value ?? false);
      if (shouldLogOut) {
        await ref.read(authStateNotifierProvider.notifier).logOut();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Impostazioni'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          settingsSection(
            'Account',
            [
              settingsTile(
                context,
                'Esci dall\'account',
                Icons.logout,
                () => shouldLogOut(context),
              ),
              settingsTile(
                  context, 'Cancella account', Icons.delete, () => null),
            ],
            context,
          ),
          settingsSection(
            'Profilo',
            [
              settingsTile(context, 'Cambia immagine del profilo', Icons.image,
                  () => null),
              settingsTile(
                  context, 'Cambia Linguaggio', Icons.language, () => null),
            ],
            context,
          ),
          Visibility(
            //user has to be logged in to see this section
            visible: ref.watch(
              isLoggedInProvider,
            ),
            child: settingsSection(
              'Gestione Tracciato',
              [
                settingsTile(
                  context,
                  'Gestisci i tuoi tracciati',
                  Icons.edit,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackOwnershipStepper(),
                    ),
                  ),
                ),
              ],
              context,
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsSection(
      String title, List<Widget> children, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .primaryColor, // Use the primary color of the theme
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget settingsTile(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context)
            .iconTheme
            .color, // Use the color of the theme's icons
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.color, // Use the color of the theme's body text
        ),
      ),
      onTap: onTap,
    );
  }
}
