//Explicacion al final del codigo
part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  // Polylines
  final Map<String, Polyline> polylines;

  const MapState(
      {this.isMapInitialized = false,
      this.isFollowingUser = true,
      this.showMyRoute = true,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  MapState copyWith(
          {bool? isMapInitialized,
          bool? isFollowingUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
      );

  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showMyRoute, polylines];
}

//EXPLICACION DE TODO EL CODIGO
/**
 * 
 * Linea 7: Se inicializa la variable para mostrar la polyline del recorrido
 * del usuario
 * 
 * Linea 10: Se crea el mapa que va a almacenar las polylines
 * 
 * Lineas 15 a 17: Se agregan la variable y el map al constructor y adicional
 * se hace una validacion donde se indica que si el map de polylines no tiene
 * nada, se envíe una lista vacia en cambio de la polyline.
 * 
 * Lineas 22 y 23: Se agregan las variables a la lista de copias.
 * 
 * Lineas 27 y 28: Se agregan las validaciones de la lista de copias.
 * 
 */