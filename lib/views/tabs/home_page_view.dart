import '../../common/responsive.dart';
import '../../features/map/presentation/map_screen.dart';
import '../components/bottom_bar/bottom_bar.dart';
import '../components/bottom_bar/nav_states/nav_notifier.dart';
import '../components/top_bar/top_bar.dart';
import 'settings_page_view.dart';
import 'track_action.dart';

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
        resizeToAvoidBottomInset: false,
        body: ResponsiveContainer(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TopBar(),
                Responsive.value(context, mobile: 5, tablet: 8, desktop: 10).verticalSpace,
                const NavigationIndexedStack(),
                Responsive.value(context, mobile: 5, tablet: 8, desktop: 10).verticalSpace,
                const BottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationIndexedStack extends ConsumerWidget {
  const NavigationIndexedStack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navProvider).index;
    return Expanded(
      child: IndexedStack(
        index: navIndex,
        children: HomePageView.widgetList,
      ),
    );
  }
}
