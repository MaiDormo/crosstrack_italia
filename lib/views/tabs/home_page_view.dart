import 'package:crosstrack_italia/news_view.dart';
import 'package:crosstrack_italia/views/tabs/settings_page_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app_states/nav_states/nav_notifier.dart';
import '../../top_bar.dart';
import '../../bottom_bar.dart';
import '../../map_screen_view.dart';

class HomePageView extends ConsumerWidget {
  const HomePageView({super.key});
  static List<Widget> widgetList = [
    const Flexible(child: MapScreenView()),
    const Flexible(child: NewsView()),
    const Flexible(child: SettingsPageView()),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //to avoid overflow
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Top of the screen
              const TopBar(),
              const SizedBox(height: 5),
              //middle of the screen
              Consumer(
                builder: (context, ref, child) {
                  final navIndex = ref.watch(navProvider).index;
                  return widgetList[navIndex];
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