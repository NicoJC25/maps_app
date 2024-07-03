//Explicacion al final del codigo
part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}

class OnStopFollowingUserEvent extends MapEvent {}

class OnStartFollowingUserEvent extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocation;
  const UpdateUserPolylineEvent(this.userLocation);
}

class OnToggleUserRoute extends MapEvent {}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  const DisplayPolylinesEvent(this.polylines);
}


//EXPLICACION DE TODO EL CODIGO
/**
 * 
 * Lineas 27 a la 30: Se crea un nuevo evento que va a obtener un mapa de
 * polylines que serán las polylines del punto A al punto B.
 * 
 */