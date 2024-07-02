//Explicacion al final del codigo
part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const OnNewUserLocationEvent(this.newLocation);
}

class OnStartFollowingUser extends LocationEvent {}

class OnStopFollowingUser extends LocationEvent {}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 10 a la 14: Se crea una clase llamada "OnNewUserLocationEvent" extendida
 * de la clase anterior, en la que, se crea la variable "newLocation" ya vista
 * antes y, se agrega al constructor.
 * 
 * Lineas 16 y 18: Creacion de las clases para abrir y cerrar el flujo vistas
 * en el otro archivo.
 * 
 */