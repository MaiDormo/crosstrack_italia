import 'package:crosstrack_italia/common/responsive.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/map_widget/floating_search_map_bar.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/map_widget/map.dart';
import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:crosstrack_italia/features/map/presentation/panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

//------------------RIVERPOD------------------//
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Responsive panel height - smaller on larger screens relative to content
    final screenHeight = Responsive.screenHeight(context);
    final panelHeightOpen = Responsive.value(
      context,
      mobile: 526.h,
      tablet: (screenHeight * 0.5).clamp(400.0, 600.0),
      desktop: (screenHeight * 0.5).clamp(400.0, 600.0),
    );
    final panelController = ref.watch(panelControllerProvider);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.value(context, mobile: 8.0, tablet: 12.0, desktop: 16.0)).h,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: SlidingUpPanel(
              controller: ref.watch(panelControllerProvider),
              minHeight: 0.0,
              maxHeight: panelHeightOpen,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              color: Theme.of(context).colorScheme.secondary,
              body: const ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Map(),
                    FloatingSearchMapBar(),
                  ],
                ),
              ),
              panelBuilder: (scrollController) => SafeArea(
                child: PanelWidget(
                  null,
                  hideDragHandle: false,
                  scrollController: scrollController,
                  panelController: panelController,
                ),
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
