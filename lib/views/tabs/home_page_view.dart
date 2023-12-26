import 'package:crosstrack_italia/features/map/presentation/map_screen.dart';
import 'package:crosstrack_italia/views/components/bottom_bar/bottom_bar.dart';
import 'package:crosstrack_italia/views/components/bottom_bar/nav_states/nav_notifier.dart';
import 'package:crosstrack_italia/views/components/top_bar/top_bar.dart';
import 'package:crosstrack_italia/views/tabs/settings_page_view.dart';
import 'package:crosstrack_italia/views/tabs/track_action.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  static const List<Widget> widgetList = [
    MapScreen(),
    TrackAction(),
    SettingsPageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //to avoid overflow
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Top of the screen
              const TopBar(),
              5.verticalSpace,
              //middle of the screen
              const NavigationIndexedStack(),
              5.verticalSpace,
              //bottom of the screen
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationIndexedStack extends ConsumerWidget {
  const NavigationIndexedStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navNotifierProvider).index;
    return Expanded(
      child: IndexedStack(
        index: navIndex,
        children: HomePageView.widgetList,
      ),
    );
  }
}
