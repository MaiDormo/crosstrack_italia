import 'package:flutter/foundation.dart' show immutable;
import 'package:latlong2/latlong.dart';

@immutable
class MapConstants {

  const MapConstants._();
  //used for the marker
  static const markerSize = 40.0;
  static const thumbnail = 'img1.jpg';
  static const placeholder = 'assets/images/placeholder.jpg';
  static const scaleImage = 0.5;

  //used in get closest location
  static const initialLocation = 'Attiva posizione';
  static const errorLocation = 'Errore';
  static const noLocationFound = '';
  static const loading = 'Caricamento...';
  static const localeIdentifier = 'it_IT';

  //used in map screen
  static const milan = LatLng(45.464664, 9.188540);
  static const trento = LatLng(46.0667, 11.1167);
  static const venice = LatLng(45.4408, 12.3155);
  static const defaultLocation = LatLng(45.545463, 10.636139);
  static const defaultZoom = 7.5;
  static const veneto = 'Veneto';
  static const lombardia = 'Lombardia';
  static const trentinoAltoAdige = 'Trentino Alto Adige';
  static const all = 'Tutte';

  //vsync
  static const vsyncLabel = 'vsync';
}
