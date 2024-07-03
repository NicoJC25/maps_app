import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteDestination {
  final List<LatLng> points;
  final double duration;
  final double distance;

  RouteDestination(
      {required this.points, required this.duration, required this.distance});
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Este es el modelo para traer los datos finales de las polylinea de punto A
 * a punto B. Se requieren los puntos, la duracion del recorrido y la distancia.
 * 
 */