import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_swiper.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_track_name_and_location.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/build_track_rating_and_map_button.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/build_track_cards.dart';
import 'package:crosstrack_italia/features/map/providers/panel_style.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
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
    final heightFactor = ref.watch(heightFactorProvider(context));

    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      children: <Widget>[
        SizedBox(height: heightFactor * 12),
        buildDragHandle(),
        Consumer(
          builder: (context, _, child) => buildTrackInfo(
            trackSelected,
            allTrackImages,
            context,
            heightFactor,
          ),
        ),
        SizedBox(height: heightFactor * 12),
      ],
    );
  }

  Widget buildTrackInfo(
    Track trackSelected,
    AsyncValue<Iterable<Image>> allTrackImages,
    BuildContext context,
    double heightFactor,
  ) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTrackImagesSwiper(allTrackImages, context, heightFactor),
            buildTrackName(trackSelected, context, heightFactor),
            buildTrackLocation(trackSelected, heightFactor),
            buildTrackRatingAndMapButton(trackSelected, context, heightFactor),
            SizedBox(height: 12 * heightFactor),
            buildTrackCards(trackSelected, context, heightFactor),
          ],
        ),
      );

  Widget buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 40,
            height: 5,
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
