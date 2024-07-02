part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsAndPermissionEvent(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});
}

//EXPLICACION DE TODO EL CODIGO
/**
 * 
 * Se utiliza la clase creada por el comando, "GpsEvent", la cual solo tendra
 * una lista de tipo "get" que obtiene valores.
 * 
 * Mas abajo, se crea o si ya se tiene, se utiliza la clase "GpsAndPermissionEvent"
 * la cual creará las dos variables booleanas para validar los permisos.
 * 
 */