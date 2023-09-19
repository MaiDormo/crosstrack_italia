import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:clipboard/clipboard.dart';
import 'package:crosstrack_italia/states/track_info/models/track_info_model.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/all_track_images_provider.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PanelWidget extends ConsumerWidget {
  final ScrollController scrollController;
  final PanelController panelController;

  const PanelWidget(
      {super.key,
      required this.scrollController,
      required this.panelController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackSelected = ref.watch(trackSelectedProvider);
    final allTrackImages = ref.watch(allTrackImagesProvider(trackSelected));
    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      children: <Widget>[
        const SizedBox(height: 12),
        buildDragHandle(),
        const SizedBox(height: 12),
        Consumer(builder: (context, _, child) {
          return buildTrackInfo(trackSelected, allTrackImages, context);
        }),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget buildTrackInfo(TrackInfoModel? trackSelected,
      AsyncValue<Iterable<Image>> allTrackImages, BuildContext context) {
    final rating = (Random().nextDouble() * 5).floorToDouble();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trackSelected?.trackName ?? 'No track selected',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            trackSelected?.region ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            trackSelected?.location ?? '',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Text(
                'rating: ' + rating.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              RatingBarIndicator(
                //random value between 0 and 5
                itemSize: 20,
                rating: rating,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              ),
            ],
          ),
          const SizedBox(height: 12),
          allTrackImages.when(
            data: (images) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    child: Swiper(
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: images.elementAt(index),
                        );
                      },
                      pagination: SwiperPagination(),
                      control: SwiperControl(),
                    ),
                  ),
                ),
              );
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            error: (error, stackTrace) {
              return Image.asset(
                'assets/images/placeholder.jpg',
                width: 200,
                height: 100,
                fit: BoxFit.cover,
              );
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Motoclub:  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //motoclub
                    TextSpan(
                      text: trackSelected?.motoclub ?? ' ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          //category
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Categoria:  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: trackSelected?.category ?? ' ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Licenze accettate: ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //display all of the values inside trackSelected.services in each row
                  // display all of the values inside trackSelected.services in each row
                  ...trackSelected?.acceptedLicenses!
                          .map(
                            (entry) => Row(
                              children: [
                                Text(
                                  entry,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          //trackLength and terrainType

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Lunghezza:  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: trackSelected?.trackLength ?? ' ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tipo di terreno:  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: trackSelected?.terrainType ?? ' ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          //hasMinicross
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Minicross:  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: trackSelected?.hasMinicross ?? ' ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          //services
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Servizi: ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //display all of the values inside trackSelected.services in each row
                  // display all of the values inside trackSelected.services in each row
                  ...trackSelected?.services!.entries
                          .map(
                            (entry) => Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${entry.key}:  ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: entry.value,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          //website
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  final fallBackUrl = trackSelected?.website ?? '';
                  final actualUrl = 'fb://profile/100067256400943';

                  // try {
                  //   bool launched = await launchUrlString(actualUrl,
                  //       mode: LaunchMode.externalNonBrowserApplication);

                  //   if (!launched) {
                  //     await launchUrlString(actualUrl,
                  //         mode: LaunchMode.externalNonBrowserApplication);
                  //   }
                  // } catch (e) {
                  //   await launchUrlString(fallBackUrl,
                  //       mode: LaunchMode.externalNonBrowserApplication);
                  // }

                  try {
                    await launchUrlString(fallBackUrl,
                        mode: LaunchMode.externalNonBrowserApplication);
                  } catch (e) {
                    final snackBar =
                        SnackBar(content: Text('Sito non raggiungibile'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sito web:  ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: trackSelected?.website ?? ' ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          //email
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Email:  ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: trackSelected?.email ?? ' ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  FlutterClipboard.copy(trackSelected?.email ?? '')
                      .then((value) {
                    final snackBar =
                        SnackBar(content: Text('Email copied to clipboard'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          //info
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Info:  ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: trackSelected?.info ?? ' ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          //phones
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Telefoni: ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //display all of the values inside trackSelected.services in each row
                  // display all of the values inside trackSelected.services in each row
                  ...trackSelected?.phones!
                          .map(
                            (entry) => Row(
                              children: [
                                Text(
                                  entry,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList() ??
                      [],
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          //fax
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Fax: ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (trackSelected?.fax != null)
                    ...trackSelected!.fax!
                        .map(
                          (entry) => Row(
                            children: [
                              Text(
                                entry,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
