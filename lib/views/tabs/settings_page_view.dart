import 'package:crosstrack_italia/features/auth/backend/auth_repository.dart';
import 'package:crosstrack_italia/features/user_info/constants/user_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_settings.dart';
import 'package:crosstrack_italia/features/user_info/providers/user_info_providers.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:crosstrack_italia/features/user_info/presentation/track_ownership_stepper.dart';
import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/dialogs/delete_account_dialog.dart';
import 'package:crosstrack_italia/views/components/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPageView extends ConsumerWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsMap = ref.watch(userSettingsProvider);

    Future<void> confirmAction(BuildContext context, AlertDialogModel dialog,
        Future<void> Function() action) async {
      final shouldConfirm =
          await dialog.present(context).then((value) => value ?? false);
      if (shouldConfirm) {
        await action();
      }
    }

    Future<void> shouldLogOut(BuildContext context) async {
      await confirmAction(context, const LogoutDialog(),
          () => ref.read(authRepositoryProvider).logOut());
    }

    Future<void> shouldDeleteAccount(BuildContext context) async {
      await confirmAction(context, const DeleteAccountDialog(),
          () => ref.read(userStateNotifierProvider.notifier).deleteUserInfo());
    }

    Widget settingsTile(
        BuildContext context, String title, IconData icon, VoidCallback onTap,
        {String? settingKey}) {
      return ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context)
              .canvasColor, // Use the color of the theme's icons
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
        trailing: Visibility(
          visible: settingKey != null,
          child: Switch(
            activeColor: Theme.of(context).colorScheme.onSecondary,
            activeTrackColor: Colors.green,
            value: settingsMap[settingKey ?? ''] ?? false,
            onChanged: (value) {
              ref.read(userSettingsProvider.notifier).updateSettings(
                    settingKey ?? '',
                    value,
                  );
            },
          ),
        ),
        onTap: onTap,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0).h,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView(
          padding: EdgeInsets.all(8.0).h,
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
                    () => shouldDeleteAccount(context),
                  ),
                  settingsTile(
                    context,
                    'Privacy Settings (non implementato)',
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
              'Accessibilità',
              [
                settingsTile(
                  context,
                  'Testo permanente nella barra di navigazione',
                  Icons.text_fields,
                  () => null,
                  settingKey: UserConstants.permanentTextBottomBar,
                ),
                settingsTile(
                  context,
                  'Mostra più informazioni all\'interno dell\'applicazione',
                  Icons.info,
                  () => null,
                  settingKey: UserConstants.showMoreInfo,
                ),
                settingsTile(
                  context,
                  'Mostra impostazioni in sviluppo',
                  Icons.developer_mode,
                  () => null,
                  settingKey: UserConstants.showSettingsInDevelopment,
                ),
                settingsTile(
                  context,
                  'Mostra posizione nella barra superiore',
                  Icons.location_on,
                  () => null,
                  settingKey: UserConstants.showLocationTopBar,
                ),
              ],
              context,
            ),
            Visibility(
              visible: settingsMap[UserConstants.showSettingsInDevelopment]!,
              child: settingsSection(
                '(non implementato)',
                [
                  settingsTile(
                    context,
                    'Impostazioni ricerca tracciato',
                    Icons.track_changes,
                    // () => null,
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
}
