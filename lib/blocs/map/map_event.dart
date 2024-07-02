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
//EXPLICACION DE TODO EL CODIGO
/**
 * 
 * Lineas 11 a la 14: Inicializador del controlador del mapa y del mapa como tal
 * 
 * Lineas 16 y 18: Definicion de las clases que van a iniciar y acabar el
 * seguimiento del usuario
 * 
 * Lineas 20 a la 23: Definicion de la clase para guardar cada polyline del
 * seguimiento del cliente. Se define la lista que tendra cada longitud y latitud
 * de las polylines y abajo, se envia la lista como argumento de la clase.
 * 
 * Linea 25: Se define la clase para asignar si se va a mostrar el recorrido
 * del usuario o si no.
 * 
 */