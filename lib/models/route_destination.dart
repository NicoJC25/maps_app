import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

class RouteDestination {
  final List<LatLng> points;
  final double duration;
  final double distance;
  final Feature endPlace;

  RouteDestination(
      {required this.points,
      required this.duration,
      required this.distance,
      required this.endPlace});
}

//EXPLICACION DE LOS CAMBIOS REALIZADOS:
/**
 * 
 * Linea 2: Se agrega importacion de los modelos para usar el tipo de dato "Feature"
 * 
 * Linea 8 y 14: Se agrega "endPlace" como nueva variable requerida.
 * 
 */