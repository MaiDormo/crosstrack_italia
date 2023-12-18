import 'package:crosstrack_italia/bottom_bar/nav_states/nav_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navNotifierProvider).index;

    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'Mappa',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.newspaper),
        label: 'News',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Impostazioni',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: bottomNavigationBarItems,
            currentIndex: navIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            onTap: (value) {
              ref.read(navNotifierProvider.notifier).onIndexChanged(value);
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14.0,
            unselectedFontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
