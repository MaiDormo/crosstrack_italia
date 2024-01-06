import 'package:crosstrack_italia/views/components/bottom_bar/nav_states/nav_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  @override
  void initState() {
    super.initState();
    bottomNavigationBarItems = [
      _createBottomNavigationBarItem(Icons.map, 'Mappa'),
      _createBottomNavigationBarItem(Icons.sports_score, 'Tracciati'),
      _createBottomNavigationBarItem(Icons.settings, 'Impostazioni'),
    ];
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(
    IconData icon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navNotifierProvider).index;

    return Padding(
      padding: EdgeInsets.only(
        left: 8.0.w,
        right: 8.0.w,
        bottom: 8.0.h,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: bottomNavigationBarItems,
            currentIndex: navIndex,
            selectedItemColor: Theme.of(context).colorScheme.onSecondary,
            unselectedItemColor: Colors.white54,
            unselectedLabelStyle: TextStyle(
              color: Colors.transparent,
            ),
            showUnselectedLabels: false,
            onTap: (value) {
              ref.read(navNotifierProvider.notifier).onIndexChanged(value);
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14.0.sp,
            unselectedFontSize: 12.0.sp,
          ),
        ),
      ),
    );
  }
}
