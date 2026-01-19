import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../track/models/track.dart';
import '../../track/notifiers/track_notifier.dart';
import 'widget/panel_widget/build_favorite_button.dart';
import 'widget/panel_widget/build_track_name_and_location.dart';
import 'widget/panel_widget/build_track_rating_and_map_button.dart';
import 'widget/panel_widget/track_cards/build_track_cards.dart';

class PanelWidget extends ConsumerWidget {

  const PanelWidget(
    this.track, {
    super.key,
    required this.scrollController,
    required this.panelController,
    required this.hideDragHandle,
  });


  final ScrollController scrollController;
  final PanelController panelController;
  final bool hideDragHandle;
  final Track? track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackSelected = ref.watch(trackSelectedProvider);
    final allTrackImages =
        ref.watch(allTrackImagesByTrackProvider(track ?? trackSelected, true));

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        controller: scrollController,
        children: <Widget>[
          SizedBox(height: 12.h),
          if (!hideDragHandle) buildDragHandle(context),
          SizedBox(height: 8.h),
          Consumer(
            builder: (ctx, ref, child) => buildTrackInfo(
              track ?? trackSelected,
              allTrackImages,
              context,
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget buildTrackInfo(
    Track trackSelected,
    AsyncValue<Iterable<Widget>> allTrackImages,
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with favorite button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTrackName(trackSelected, context),
                      SizedBox(height: 4.h),
                      buildTrackLocation(trackSelected),
                    ],
                  ),
                ),
                buildFavoriteButton(trackSelected, context),
              ],
            ),
            SizedBox(height: 16.h),
            buildTrackRatingAndMapButton(trackSelected, context),
            SizedBox(height: 20.h),
            buildTrackCards(trackSelected, allTrackImages, context),
          ],
        ),
      );

  Widget buildDragHandle(BuildContext context) => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
