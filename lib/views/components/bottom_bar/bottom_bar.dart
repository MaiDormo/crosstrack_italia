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
    var navIndex = ref.watch(navNotifierProvider).index;
    final _permanentTextBottomBar =
        ref.watch(userSettingsProvider)[UserConstants.permanentTextBottomBar]!;

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
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Mappa',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/icons/track_icon.svg',
                  height: 24.h,
                  width: 24.w,
                  colorFilter: ColorFilter.mode(
                    navIndex == 1
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcATop,
                  ),
                ),
                label: 'Tracciati',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Impostazioni',
              ),
            ],
            currentIndex: navIndex,
            selectedItemColor: Theme.of(context).colorScheme.onSecondary,
            unselectedItemColor: Colors.white54,
            unselectedLabelStyle: TextStyle(
              color: Colors.transparent,
            ),
            showUnselectedLabels: _permanentTextBottomBar,
            onTap: (value) {
              ref.read(navNotifierProvider.notifier).onIndexChanged(value);
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            selectedFontSize: 14.0.sp,
            unselectedFontSize: 12.0.sp,
          ),
        ),
      ),
    );
  }
}
