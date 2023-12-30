import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:crosstrack_italia/features/user_info/presentation/track_ownership_stepper.dart';
import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0).h,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView(
          padding: EdgeInsets.all(8.0).w,
          children: [
            Visibility(
              visible: ref.watch(isLoggedInProvider),
              child: settingsSection(
                'Account',
                [
                  settingsTile(
                    context,
                    'Esci dall\'account',
                    Icons.logout,
                    () => shouldLogOut(context),
                  ),
                  settingsTile(
                      context,
                      'Cancella account',
                      Icons.delete,
                      () => ref
                          .read(userStateNotifierProvider.notifier)
                          .deleteUserInfo()),
                  settingsTile(
                    context,
                    'Privacy Settings',
                    Icons.lock,
                    () => null,
                  ),
                ],
                context,
              ),
            ),
            Visibility(
              //user has to be logged in to see this section
              visible: ref.watch(
                isLoggedInProvider,
              ),
              child: settingsSection(
                'Gestore Tracciato',
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
            settingsSection(
              'Preferenze',
              [
                settingsTile(
                  context,
                  'Impostazioni ricerca tracciato',
                  Icons.track_changes,
                  () => null,
                ),
                settingsTile(
                  context,
                  'Impostazioni notifiche',
                  Icons.notifications,
                  () => null,
                ),
                settingsTile(
                  context,
                  'Unità di misura',
                  Icons.straighten,
                  () => null,
                ),
                settingsTile(
                  context,
                  'Impostazioni Meteo',
                  Icons.wb_sunny,
                  () => null,
                ),
                settingsTile(
                  context,
                  'Tema applicazione',
                  Icons.brightness_6,
                  () => null,
                ),
                settingsTile(
                  context,
                  'Impostazioni lingua',
                  Icons.language,
                  () => null,
                ),
              ],
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsSection(
      String title, List<Widget> children, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0).h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .colorScheme
                    .tertiary, // Use the primary color of the theme
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
        color:
            Theme.of(context).canvasColor, // Use the color of the theme's icons
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
