import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_favorite_button.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_swiper.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_track_name_and_location.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_track_rating_and_map_button.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/build_track_cards.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends ConsumerWidget {
  final ScrollController scrollController;
  final PanelController panelController;

  const PanelWidget({
    super.key,
    required this.scrollController,
    required this.panelController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackSelected = ref.watch(trackSelectedProvider);
    final allTrackImages = ref.watch(allTrackImagesProvider);

    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      children: <Widget>[
        9.verticalSpace,
        buildDragHandle(),
        Consumer(
          builder: (ctx, ref, child) => buildTrackInfo(
            trackSelected,
            allTrackImages,
            context,
          ),
        ),
        9.verticalSpace,
      ],
    );
  }

  Widget buildTrackInfo(
    Track trackSelected,
    AsyncValue<Iterable<Image>> allTrackImages,
    BuildContext context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFavoriteButton(trackSelected, context),
            buildTrackImagesSwiper(allTrackImages, context),
            buildTrackName(trackSelected, context),
            buildTrackLocation(trackSelected),
            buildTrackRatingAndMapButton(trackSelected, context),
            buildTrackCards(trackSelected, context),
          ],
        ),
      );

  Widget buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 40.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onTap: togglePanel,
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}




  // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: GestureDetector(
          //       onTap: () async {
          //         final fallBackUrl = trackSelected?.website ?? '';
          //         // final actualUrl = 'fb://profile/100067256400943';

          //         // try {
          //         //   bool launched = await launchUrlString(actualUrl,
          //         //       mode: LaunchMode.externalNonBrowserApplication);

          //         //   if (!launched) {
          //         //     await launchUrlString(actualUrl,
          //         //         mode: LaunchMode.externalNonBrowserApplication);
          //         //   }
          //         // } catch (e) {
          //         //   await launchUrlString(fallBackUrl,
          //         //       mode: LaunchMode.externalNonBrowserApplication);
          //         // }

          //         try {
          //           await launchUrlString(fallBackUrl,
          //               mode: LaunchMode.externalNonBrowserApplication);
          //         } catch (e) {
          //           final snackBar =
          //               SnackBar(content: Text('Sito non raggiungibile'));
          //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //         }
          //       },
          //
