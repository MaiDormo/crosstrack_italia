import 'package:crosstrack_italia/features/user_info/constants/user_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_settings.dart';
import 'package:crosstrack_italia/views/components/bottom_bar/nav_states/nav_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final navIndex = ref.watch(navProvider).index;
    final permanentTextBottomBar =
        ref.watch(userSettingsProvider)[UserConstants.permanentTextBottomBar]!;
    final colorScheme = Theme.of(context).colorScheme;

    // Colors for the bottom bar
    const selectedColor = Colors.white;
    final unselectedColor = Colors.white.withValues(alpha: 0.6);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Mappa',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/icons/track_icon.svg',
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    navIndex == 1 ? selectedColor : unselectedColor,
                    BlendMode.srcATop,
                  ),
                ),
                label: 'Tracciati',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Impostazioni',
              ),
            ],
            currentIndex: navIndex,
            selectedItemColor: selectedColor,
            unselectedItemColor: unselectedColor,
            unselectedLabelStyle: TextStyle(
              color: unselectedColor,
            ),
            showUnselectedLabels: permanentTextBottomBar,
            onTap: (value) {
              ref.read(navProvider.notifier).onIndexChanged(value);
            },
            backgroundColor: colorScheme.secondary,
            selectedFontSize: 14.0.sp,
            unselectedFontSize: 12.0.sp,
          ),
        ),
      ),
    );
  }
}
