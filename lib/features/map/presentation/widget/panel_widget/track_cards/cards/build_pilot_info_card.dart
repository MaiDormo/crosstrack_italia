import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';

Widget buildPilotInfoCard(
        Track trackSelected, BuildContext context, double heightFactor) =>
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
              Row(
                children: [
                  const Icon(
                    Icons.badge_outlined,
                  ),
                  SizedBox(
                    width: 5 * heightFactor,
                  ),
                  Column(
                    children: [
                      ...trackSelected.acceptedLicenses
                          .map(
                            (license) => switch (license) {
                              'fmi' => buildLicenseCard(
                                  'fmi',
                                  'assets/images/license_img/logo-fmi.jpg',
                                  heightFactor),
                              'uisp' => buildLicenseCard(
                                  'uisp',
                                  'assets/images/license_img/logo-uisp.jpg',
                                  heightFactor),
                              'asi' => buildLicenseCard(
                                  'asi',
                                  'assets/images/license_img/logo_motoasi.jpg',
                                  heightFactor),
                              'csen' => buildLicenseCard(
                                  'csen',
                                  'assets/images/license_img/logo-csen.jpg',
                                  heightFactor),
                              'asc' => buildLicenseCard(
                                  'asc',
                                  'assets/images/license_img/logo-asc.jpg',
                                  heightFactor),
                              _ => Container(),
                            },
                          )
                          .toList(),
                      SizedBox(
                        width: 5 * heightFactor,
                      ),
                    ],
                  ),
                ],
              ),

              //minicross
              buildMinicrossRow(
                'Minicross:',
                trackSelected.hasMinicross,
                heightFactor,
              ),
            ],
          ),
        ),
      ),
    );

Widget buildLicenseCard(
        String license, String imagePath, double heightFactor) =>
    Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                imagePath,
                height: 50 * heightFactor,
                width: 50 * heightFactor,
              ),
            ),
            SizedBox(
              width: 5.0 * heightFactor,
            ),
            Text(license),
          ],
        ),
      ),
    );

Widget buildMinicrossRow(String label, String value, double heightFactor) =>
    Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15 * heightFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: switch (value) {
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
    );
