import '../../features/auth/backend/auth_repository.dart';
import '../../features/user_info/constants/user_constants.dart';
import '../../features/user_info/notifiers/user_settings.dart';
import '../../features/user_info/providers/user_info_providers.dart';
import '../../features/user_info/notifiers/user_state_notifier.dart';
import '../../features/user_info/presentation/track_ownership_stepper.dart';
import '../components/dialogs/alert_dialog_model.dart';
import '../components/dialogs/delete_account_dialog.dart';
import '../components/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPageView extends ConsumerWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsMap = ref.watch(userSettingsProvider);
    final colorScheme = Theme.of(context).colorScheme;

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
          () => ref.read(userStateProvider.notifier).deleteUserInfo());
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: ListView(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  'Impostazioni',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              
              // Account section
              if (ref.watch(isLoggedInProvider)) ...[
                _buildSection(
                  context: context,
                  title: 'Account',
                  icon: Icons.person_outline_rounded,
                  children: [
                    _buildSettingsTile(
                      context: context,
                      title: 'Esci dall\'account',
                      icon: Icons.logout_rounded,
                      onTap: () => shouldLogOut(context),
                      colorScheme: colorScheme,
                    ),
                    _buildSettingsTile(
                      context: context,
                      title: 'Cancella account',
                      icon: Icons.delete_outline_rounded,
                      onTap: () => shouldDeleteAccount(context),
                      colorScheme: colorScheme,
                      isDestructive: true,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
              
              // Track Manager section
              if (ref.watch(isLoggedInProvider)) ...[
                _buildSection(
                  context: context,
                  title: 'Gestore Tracciato',
                  icon: Icons.edit_road_rounded,
                  children: [
                    _buildSettingsTile(
                      context: context,
                      title: 'Gestisci i tuoi tracciati',
                      icon: Icons.edit_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrackOwnershipStepper(),
                        ),
                      ),
                      colorScheme: colorScheme,
                      showChevron: true,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
              
              // Accessibility section
              _buildSection(
                context: context,
                title: 'Accessibilità',
                icon: Icons.accessibility_new_rounded,
                children: [
                  _buildToggleTile(
                    context: context,
                    title: 'Testo permanente nella barra di navigazione',
                    icon: Icons.text_fields_rounded,
                    settingKey: UserConstants.permanentTextBottomBar,
                    settingsMap: settingsMap,
                    ref: ref,
                    colorScheme: colorScheme,
                  ),
                  _buildToggleTile(
                    context: context,
                    title: 'Mostra più informazioni',
                    icon: Icons.info_outline_rounded,
                    settingKey: UserConstants.showMoreInfo,
                    settingsMap: settingsMap,
                    ref: ref,
                    colorScheme: colorScheme,
                  ),
                  _buildToggleTile(
                    context: context,
                    title: 'Mostra impostazioni in sviluppo',
                    icon: Icons.developer_mode_rounded,
                    settingKey: UserConstants.showSettingsInDevelopment,
                    settingsMap: settingsMap,
                    ref: ref,
                    colorScheme: colorScheme,
                  ),
                  _buildToggleTile(
                    context: context,
                    title: 'Mostra posizione nella barra superiore',
                    icon: Icons.location_on_outlined,
                    settingKey: UserConstants.showLocationTopBar,
                    settingsMap: settingsMap,
                    ref: ref,
                    colorScheme: colorScheme,
                  ),
                ],
              ),
              
              // Development section
              if (settingsMap[UserConstants.showSettingsInDevelopment]!) ...[
                SizedBox(height: 16.h),
                _buildSection(
                  context: context,
                  title: 'In Sviluppo',
                  icon: Icons.construction_rounded,
                  children: [
                    _buildSettingsTile(
                      context: context,
                      title: 'Impostazioni ricerca tracciato',
                      icon: Icons.search_rounded,
                      onTap: () {},
                      colorScheme: colorScheme,
                      isDisabled: true,
                    ),
                    _buildSettingsTile(
                      context: context,
                      title: 'Impostazioni notifiche',
                      icon: Icons.notifications_outlined,
                      onTap: () {},
                      colorScheme: colorScheme,
                      isDisabled: true,
                    ),
                    _buildSettingsTile(
                      context: context,
                      title: 'Tema applicazione',
                      icon: Icons.palette_outlined,
                      onTap: () {},
                      colorScheme: colorScheme,
                      isDisabled: true,
                    ),
                    _buildSettingsTile(
                      context: context,
                      title: 'Lingua',
                      icon: Icons.language_rounded,
                      onTap: () {},
                      colorScheme: colorScheme,
                      isDisabled: true,
                    ),
                  ],
                ),
              ],
              
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 18.r,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    bool isDestructive = false,
    bool isDisabled = false,
    bool showChevron = false,
  }) {
    final color = isDestructive 
        ? const Color(0xFFEF4444) 
        : isDisabled 
            ? colorScheme.onSurface.withValues(alpha: 0.4)
            : colorScheme.onSurface;
            
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22.r,
                color: isDestructive 
                    ? const Color(0xFFEF4444)
                    : colorScheme.tertiary,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
              if (showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22.r,
                  color: colorScheme.tertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String settingKey,
    required Map<String, bool> settingsMap,
    required WidgetRef ref,
    required ColorScheme colorScheme,
  }) {
    final isEnabled = settingsMap[settingKey] ?? false;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22.r,
            color: colorScheme.tertiary,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Switch.adaptive(
            value: isEnabled,
            activeColor: const Color(0xFF10B981),
            onChanged: (value) {
              ref.read(userSettingsProvider.notifier).updateSettings(
                settingKey,
                value,
              );
            },
          ),
        ],
      ),
    );
  }
}
