import 'package:crosstrack_italia/bottom_bar/bottom_bar.dart';
import 'package:crosstrack_italia/bottom_bar/nav_states/nav_notifier.dart';
import 'package:crosstrack_italia/features/map/presentation/map_screen.dart';
import 'package:crosstrack_italia/top_bar.dart';
import 'package:crosstrack_italia/views/tabs/settings_page_view.dart';
import 'package:crosstrack_italia/views/tabs/track_action.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});
  static List<Widget> widgetList = [
    MapScreen(),
    // NewsView(),
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
              const SizedBox(height: 5),
              //middle of the screen
              Consumer(
                builder: (context, ref, child) {
                  final navIndex = ref.watch(navNotifierProvider).index;
                  return Expanded(
                    child: IndexedStack(
                      index: navIndex,
                      children: widgetList,
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              //bottom of the screen
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
