import 'package:card_swiper/card_swiper.dart';
import 'package:crosstrack_italia/features/map/providers/panel_style.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/comment_section.dart';
import 'package:crosstrack_italia/features/weather/presentation/view/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
    // final allTrackImages = ref.watch(allTrackImagesProvider(trackSelected));
    final allTrackImages = ref.watch(allTrackImagesProvider);
    final heightFactor = ref.watch(heightFactorProvider(context));

    return ListView(
      padding: EdgeInsets.zero,
      controller: scrollController,
      children: <Widget>[
        SizedBox(height: heightFactor * 12),
        buildDragHandle(),
        Consumer(builder: (context, _, child) {
          return buildTrackInfo(
            trackSelected,
            allTrackImages,
            context,
            heightFactor,
          );
        }),
        SizedBox(height: heightFactor * 12),
      ],
    );
  }

  Widget buildTrackInfo(
    Track trackSelected,
    AsyncValue<Iterable<Image>> allTrackImages,
    BuildContext context,
    double heightFactor,
  ) {
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
                    height: 350 * heightFactor,
                    width: MediaQuery.of(context).size.width,
                    child: Swiper(
                      layout: SwiperLayout.DEFAULT,
                      itemCount: images.length,
                      itemWidth: MediaQuery.of(context).size.width,
                      itemBuilder: (BuildContext context, int index) {
                        return images.elementAt(index);
                      },
                      pagination: SwiperPagination(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        builder: SwiperPagination.dots,
                      ),
                      autoplay: true,
                      autoplayDelay: 4000,
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
                  width: 200 * heightFactor,
                  height: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          Text(
            trackSelected.trackName,
            style: TextStyle(
              fontSize: 20 * heightFactor,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          Text(
            trackSelected.location,
            style: TextStyle(
              fontSize: 14 * heightFactor,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'Valutazione: ' + trackSelected.rating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 16 * heightFactor,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  RatingBarIndicator(
                    //random value between 0 and 5
                    physics: NeverScrollableScrollPhysics(),
                    itemSize: 20 * heightFactor,
                    rating: trackSelected.rating,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                ],
              ),

              //add a button to open google maps
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return ElevatedButton(
                    onPressed: () => ref
                        .read(
                      openGoogleMapProvider(trackSelected),
                    )
                        .when(
                      data: (value) {
                        if (value) {
                          final snackBar = SnackBar(
                              content: Text('Apertura Google Maps in corso'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                              content: Text('Google Maps non disponibile'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      loading: () {
                        final snackBar = SnackBar(
                            content: Text('Apertura Google Maps in corso'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      error: (error, stackTrace) {
                        final snackBar = SnackBar(
                            content: Text('Google Maps non disponibile'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text('Indicazioni'),
                        SizedBox(width: 4 * heightFactor),
                        Icon(Icons.directions),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),

          //show the number of reviews/comments on the track
          Text(
            'Recensioni: ' + trackSelected.commentCount.toString(),
            style: TextStyle(
              fontSize: 16 * heightFactor,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 12 * heightFactor),

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
                                '${trackSelected.motoclub}',
                                style: TextStyle(
                                    fontSize: 15 * heightFactor,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 4 * heightFactor,
                              ),
                              SvgPicture.asset(
                                'assets/svgs/f_logo.svg',
                                height: 50 * heightFactor,
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
                                  fontSize: 15 * heightFactor,
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
                                  SizedBox(
                                    width: 4 * heightFactor,
                                  ),
                                  Text(
                                    'Categoria: ',
                                    style: TextStyle(
                                      fontSize: 15 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4 * heightFactor,
                                  ),
                                  Text(
                                    trackSelected.category,
                                    style: TextStyle(
                                      fontSize: 15 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.gesture),
                                  SizedBox(
                                    width: 4 * heightFactor,
                                  ),
                                  Text(
                                    'Lunghezza: ',
                                    style: TextStyle(
                                      fontSize: 15 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4 * heightFactor,
                                  ),
                                  Text(
                                    trackSelected.trackLength,
                                    style: TextStyle(
                                      fontSize: 15 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Wrap(
                                children: [
                                  const Icon(
                                    Icons.terrain,
                                  ),
                                  SizedBox(
                                    width: 4 * heightFactor,
                                  ),
                                  Text(
                                    'Terreno: ',
                                    style: TextStyle(
                                      fontSize: 15 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4 * heightFactor,
                                  ),
                                  Text(
                                    trackSelected.terrainType,
                                    style: TextStyle(
                                      fontSize: 15 * heightFactor,
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
                SizedBox(height: 12 * heightFactor),
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
                                  fontSize: 15 * heightFactor,
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
                                  SizedBox(
                                    width: 5 * heightFactor,
                                  ),
                                  // const Text(
                                  //   'Licenze: ',
                                  //   style: TextStyle(
                                  //     fontSize: 15 * heightFactor,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),

                                  //FMI

                                  Column(
                                    children: [
                                      ...trackSelected.acceptedLicenses
                                          .map(
                                            (license) => switch (license) {
                                              'fmi' => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/license_img/logo-fmi.jpg',
                                                            height: 50 *
                                                                heightFactor,
                                                            width: 50 *
                                                                heightFactor,
                                                          ),
                                                        ),
                                                        Text('fmi'),
                                                        SizedBox(
                                                          width: 5.0 *
                                                              heightFactor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              /////////////////////////////
                                              'uisp' => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/license_img/logo-uisp.jpg',
                                                            height: 50 *
                                                                heightFactor,
                                                            width: 50 *
                                                                heightFactor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0 *
                                                              heightFactor,
                                                        ),
                                                        Text('uisp'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              /////////////////////////////
                                              'asi' => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/license_img/logo_motoasi.jpg',
                                                            height: 50 *
                                                                heightFactor,
                                                            width: 50 *
                                                                heightFactor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0 *
                                                              heightFactor,
                                                        ),
                                                        Text('asi'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              //////////////////////////////
                                              'csen' => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/license_img/logo-csen.jpg',
                                                            height: 50 *
                                                                heightFactor,
                                                            width: 50 *
                                                                heightFactor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0 *
                                                              heightFactor,
                                                        ),
                                                        Text('csen'),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ///
                                              'asc' => Card(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          child: Image.asset(
                                                            'assets/images/license_img/logo-asc.jpg',
                                                            height: 50 *
                                                                heightFactor,
                                                            width: 50 *
                                                                heightFactor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0 *
                                                              heightFactor,
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
                                          .toList(),

                                      SizedBox(
                                        width: 5 * heightFactor,
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
                                      fontSize: 15 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: switch (
                                          trackSelected.hasMinicross) {
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Servizi: ',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 16 * heightFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //show a slider to toggle between services text and icons
                                  Consumer(
                                    builder: (
                                      BuildContext context,
                                      WidgetRef ref,
                                      Widget? child,
                                    ) {
                                      final _value =
                                          ref.watch(toggleServicesViewProvider);
                                      return Tooltip(
                                        message:
                                            'Switch between text and icons',
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors
                                              .orange, // Change the tooltip background color
                                        ),
                                        textStyle: TextStyle(
                                          color: Colors
                                              .white, // Change the tooltip text color
                                          fontWeight: FontWeight
                                              .bold, // Make the tooltip text bold
                                        ),
                                        child: Switch(
                                          value: _value,
                                          onChanged: (value) => ref
                                              .read(toggleServicesViewProvider
                                                  .notifier)
                                              .toggle(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              //display all of the values inside trackSelected.services in each row
                              // display all of the values inside trackSelected.services in each row
                              ...trackSelected.services!.entries
                                  .map(
                                    (entry) => Row(
                                      children: [
                                        Consumer(
                                          builder: (
                                            BuildContext context,
                                            WidgetRef ref,
                                            Widget? child,
                                          ) {
                                            final value = ref.watch(
                                                toggleServicesViewProvider);
                                            final entryKeyCleaned =
                                                entry.key.replaceAll('_', ' ');
                                            final icon =
                                                switch (entryKeyCleaned) {
                                              'prese 220V' => Icons.bolt,
                                              'bar' => Icons.wine_bar,
                                              'illuminazione notturna' =>
                                                Icons.nightlight_round,
                                              'doccia calda' => Icons.shower,
                                              'doccia fredda' => Icons.shower,
                                              _ => Icons.check_circle_outline,
                                            };

                                            return value
                                                ? Icon(icon)
                                                : Text(
                                                    entryKeyCleaned + ':',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontSize:
                                                          13 * heightFactor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                          },
                                        ),
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            child: switch (entry.value) {
                                              'si' => Icon(
                                                  Icons.check,
                                                  color: Colors.greenAccent,
                                                  size: 18 * heightFactor,
                                                ),
                                              'no' => Icon(
                                                  Icons.close,
                                                  color: Colors.redAccent,
                                                  size: 18 * heightFactor,
                                                ),
                                              _ => Container(),
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
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

          SizedBox(height: 12 * heightFactor),
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
          //             fontSize: 16 * heightFactor,
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
          //                       fontSize: 16 * heightFactor,
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

          // const SizedBox(height: 12 * heightFactor),

          //show weather info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WeatherView(),
            ),
          ),

          SizedBox(height: 12 * heightFactor),

          //show comments
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommentsSection(
                trackId: trackSelected.id,
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
