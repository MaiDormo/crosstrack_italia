import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:crosstrack_italia/features/track_info/models/track_info_model.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/all_track_images_provider.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:crosstrack_italia/features/weather/presentation/view/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const height_unit = 0.8;

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
        const SizedBox(height: height_unit * 12),
        buildDragHandle(),
        Consumer(builder: (context, _, child) {
          return buildTrackInfo(trackSelected, allTrackImages, context);
        }),
        const SizedBox(height: height_unit * 12),
      ],
    );
  }

  Widget buildTrackInfo(TrackInfoModel? trackSelected,
      AsyncValue<Iterable<Image>> allTrackImages, BuildContext context) {
    ///TODO: how is changing if it's final
    final rating = (Random().nextDouble() * 5).floorToDouble();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Track Images Swiper
          Consumer(
            builder: (context, ref, widget) => allTrackImages.when(
              data: (images) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300 * height_unit,
                    width: MediaQuery.of(context).size.width,
                    child: Swiper(
                      layout: SwiperLayout.DEFAULT,
                      itemCount: images.length,
                      itemWidth: MediaQuery.of(context).size.width,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: images.elementAt(index),
                        );
                      },
                      pagination: SwiperPagination(
                        builder: SwiperPagination.dots,
                      ),
                      control: SwiperControl(
                        iconNext: Icons.arrow_forward_outlined,
                        iconPrevious: Icons.arrow_back_outlined,
                      ),
                    ),
                  ),
                );
              },
              loading: () {
                return Center(child: const CircularProgressIndicator());
              },
              error: (error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.jpg',
                  width: 200 * height_unit,
                  height: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          Text(
            trackSelected?.trackName ?? 'No track selected',
            style: TextStyle(
              fontSize: 20 * height_unit,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          //REGION
          // Text(
          //   trackSelected?.region ?? '',
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          Text(
            trackSelected?.location ?? '',
            style: TextStyle(
              fontSize: 14 * height_unit,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          Row(
            children: [
              Text(
                'valutazione: ' + rating.toString(),
                style: TextStyle(
                  fontSize: 16 * height_unit,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              RatingBarIndicator(
                //random value between 0 and 5
                physics: NeverScrollableScrollPhysics(),
                itemSize: 20 * height_unit,
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
          const SizedBox(height: 12 * height_unit),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //card 1 will contain the name of the motoclub and a facebook logo
                    // that links to the facebook page of the motoclub
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '${trackSelected?.motoclub}',
                                style: TextStyle(
                                    fontSize: 15 * height_unit,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(
                                height: 4 * height_unit,
                              ),
                              SvgPicture.asset(
                                'assets/svgs/f_logo.svg',
                                height: 50 * height_unit,
                                colorFilter: ColorFilter.mode(
                                  Colors.blueAccent,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //card 2 contains the track info like category, track length, terrain type, etc
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //INFO
                              Text(
                                'Infomazioni Tracciato',
                                style: TextStyle(
                                  fontSize: 15 * height_unit,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                              //category
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.military_tech,
                                  ),
                                  const SizedBox(
                                    width: 4 * height_unit,
                                  ),
                                  const Text(
                                    'Categoria: ',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4 * height_unit,
                                  ),
                                  Text(
                                    trackSelected?.category ?? '_',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.gesture),
                                  const SizedBox(
                                    width: 4 * height_unit,
                                  ),
                                  const Text(
                                    'Lunghezza: ',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4 * height_unit,
                                  ),
                                  Text(
                                    trackSelected?.trackLength ?? '_',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.terrain,
                                  ),
                                  const SizedBox(
                                    width: 4 * height_unit,
                                  ),
                                  const Text(
                                    'Terreno: ',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4 * height_unit,
                                  ),
                                  Text(
                                    trackSelected?.terrainType ?? '_',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12 * height_unit),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //card 3 contains all the info necessary to the driver, like
                    // accepted licenses, minicross
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //title
                              Text(
                                'Info pilota',
                                style: TextStyle(
                                  fontSize: 15 * height_unit,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),

                              //accepted licenses
                              Row(
                                children: [
                                  const Icon(
                                    Icons.badge_outlined,
                                  ),
                                  const SizedBox(
                                    width: 5 * height_unit,
                                  ),
                                  // const Text(
                                  //   'Licenze: ',
                                  //   style: TextStyle(
                                  //     fontSize: 15 * height_unit,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),

                                  //FMI

                                  Column(
                                    children: [
                                      ...trackSelected?.acceptedLicenses
                                              ?.map(
                                                (license) => switch (license) {
                                                  'fmi' => Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/license_img/logo-fmi.jpg',
                                                                height: 50 *
                                                                    height_unit,
                                                                width: 50 *
                                                                    height_unit,
                                                              ),
                                                            ),
                                                            Text('fmi'),
                                                            const SizedBox(
                                                              width: 5.0 *
                                                                  height_unit,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  /////////////////////////////
                                                  'uisp' => Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/license_img/logo-uisp.jpg',
                                                                height: 50 *
                                                                    height_unit,
                                                                width: 50 *
                                                                    height_unit,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0 *
                                                                  height_unit,
                                                            ),
                                                            Text('uisp'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  /////////////////////////////
                                                  'asi' => Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/license_img/logo_motoasi.jpg',
                                                                height: 50 *
                                                                    height_unit,
                                                                width: 50 *
                                                                    height_unit,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0 *
                                                                  height_unit,
                                                            ),
                                                            Text('asi'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  //////////////////////////////
                                                  'csen' => Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/license_img/logo-csen.jpg',
                                                                height: 50 *
                                                                    height_unit,
                                                                width: 50 *
                                                                    height_unit,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0 *
                                                                  height_unit,
                                                            ),
                                                            Text('csen'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ///
                                                  'asc' => Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 4.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/license_img/logo-asc.jpg',
                                                                height: 50 *
                                                                    height_unit,
                                                                width: 50 *
                                                                    height_unit,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5.0 *
                                                                  height_unit,
                                                            ),
                                                            Text('asc'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ///
                                                  _ => Container(),
                                                },
                                              )
                                              .toList() ??
                                          [],

                                      const SizedBox(
                                        width: 5 * height_unit,
                                      ),

                                      //UISP
                                    ],
                                  ),
                                ],
                              ),

                              //minicross
                              Row(
                                children: [
                                  Text(
                                    'Minicross:',
                                    style: TextStyle(
                                      fontSize: 15 * height_unit,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: switch (
                                          trackSelected?.hasMinicross ??
                                              'default') {
                                        'si' => Icon(
                                            Icons.check,
                                            color: Colors.greenAccent,
                                          ),
                                        'no' => Icon(
                                            Icons.close,
                                            color: Colors.redAccent,
                                          ),
                                        _ => Container(),
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //card 4 contains all the services of the track

                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                'Servizi: ',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16 * height_unit,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //display all of the values inside trackSelected.services in each row
                              // display all of the values inside trackSelected.services in each row
                              ...trackSelected?.services!.entries
                                      .map(
                                        (entry) => Row(
                                          children: [
                                            Text(
                                              entry.key,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 13 * height_unit,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0,
                                                    vertical: 4.0),
                                                child: switch (entry.value) {
                                                  'si' => Icon(
                                                      Icons.check,
                                                      color: Colors.greenAccent,
                                                      size: 18 * height_unit,
                                                    ),
                                                  'no' => Icon(
                                                      Icons.close,
                                                      color: Colors.redAccent,
                                                      size: 18 * height_unit,
                                                    ),
                                                  _ => Container(),
                                                },
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
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 12 * height_unit),
          //services

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
          //       child: RichText(
          //         text: TextSpan(
          //           style: Theme.of(context).textTheme.bodyMedium,
          //           children: <TextSpan>[
          //             TextSpan(
          //               text: 'Sito web:  ',
          //               style: TextStyle(
          //                 color: Theme.of(context).colorScheme.primary,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             TextSpan(
          //               text: trackSelected?.website ?? ' ',
          //               style: TextStyle(
          //                 color: Theme.of(context).colorScheme.secondary,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 decoration: TextDecoration.underline,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // const SizedBox(height: 12),
          // //email
          // const SizedBox(height: 12),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: GestureDetector(
          //       child: RichText(
          //         text: TextSpan(
          //           style: Theme.of(context).textTheme.bodyMedium,
          //           children: <TextSpan>[
          //             TextSpan(
          //               text: 'Email:  ',
          //               style: TextStyle(
          //                 color: Theme.of(context).colorScheme.primary,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             TextSpan(
          //               text: trackSelected?.email ?? ' ',
          //               style: TextStyle(
          //                 color: Theme.of(context).colorScheme.secondary,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       onTap: () {
          //         FlutterClipboard.copy(trackSelected?.email ?? '')
          //             .then((value) {
          //           final snackBar =
          //               SnackBar(content: Text('Email copied to clipboard'));
          //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //         });
          //       },
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 12),
          // //info
          // const SizedBox(height: 12),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: RichText(
          //       text: TextSpan(
          //         style: Theme.of(context).textTheme.bodyMedium,
          //         children: <TextSpan>[
          //           TextSpan(
          //             text: 'Info:  ',
          //             style: TextStyle(
          //               color: Theme.of(context).colorScheme.primary,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           TextSpan(
          //             text: trackSelected?.info ?? ' ',
          //             style: TextStyle(
          //               color: Theme.of(context).colorScheme.secondary,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 12),
          // //phones
          // const SizedBox(height: 12),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Text(
          //           'Telefoni: ',
          //           style: TextStyle(
          //             color: Theme.of(context).colorScheme.primary,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         //display all of the values inside trackSelected.services in each row
          //         // display all of the values inside trackSelected.services in each row
          //         ...trackSelected?.phones
          //                 ?.map(
          //                   (entry) => Row(
          //                     children: [
          //                       Text(
          //                         entry,
          //                         style: TextStyle(
          //                  trackSelected?.phones
          //                 ?.map(         color:
          //                               Theme.of(context).colorScheme.secondary,
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 )
          //                 .toList() ??
          //             [],
          //       ],
          //     ),
          //   ),
          // ),

          // const SizedBox(height: 12),
          // //fax
          // const SizedBox(height: 12),

          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         Text(
          //           'Fax: ',
          //           style: TextStyle(
          //             color: Theme.of(context).colorScheme.primary,
          //             fontSize: 16 * height_unit,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         ...(trackSelected?.fax ?? [])
          //             .map(
          //               (entry) => Row(
          //                 children: [
          //                   Text(
          //                     entry,
          //                     style: TextStyle(
          //                       color: Theme.of(context).colorScheme.secondary,
          //                       fontSize: 16 * height_unit,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             )
          //             .toList(),
          //       ],
          //     ),
          //   ),
          // ),

          // const SizedBox(height: 12 * height_unit),

          //show weather info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WeatherView(),
            ),
          )
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
