//Explicacion al final del codigo
part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;

  const LocationState(
      {this.followingUser = false, this.lastKnownLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
      );

  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, myLocationHistory];
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 4 a la 10: Se crean 3 variables, una correspondiente al seguimiento
 * del cliente, otra para saber la ultima ubicacion vista y la tercera, una
 * lista para almacenar el historial de la ubicacion. Se establecen en el
 * constructor y especialmente a la lista, se le indica que se retorne a si
 * misma y sus valores, y si está vacia, retorne una lista vacia.
 * 
 * Lineas 12 a la 21: Se crea la funcion relacionada a hacer la copia de las
 * otras variables para recoger los datos y mandar estos a las variables o,
 * si no hay datos, retornar nulo a estas copias.
 * 
 */