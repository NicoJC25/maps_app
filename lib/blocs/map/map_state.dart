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
 * En general, solo se envian 2 variables para saber si se inicio el mapa y si
 * se esta siguiendo el usuario, cada una tiene su funcion que por el mismo
 * nombre ya logicamente se puede saber de que se trata
 * 
 */