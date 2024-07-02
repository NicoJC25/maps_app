//Explicacion al final del codigo
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnownLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    add(OnStartFollowingUser());

    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
    //print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 11 a la 26: En la clase padre, se crea una variable llamada "StreamSubscription"
 * la cual, obtendra como valor el flujo del proceso de seguir el movimiento
 * de la persona que este usando la app. Luego, se crean 2 eventos que se van a
 * ejecutar dependiendo si se sigue haciendo seguimiento al cliente o si no,
 * dependiendo de si la aplicacion esta en otra pantalla o si se sale de la aplicacion
 * misma.
 * 
 * Por ultimo, se crea un tercer evento que va a recoger cada ultima posicion con
 * base a esta parte "event.newLocation", poniendola como valor de "lastKnownLocation"
 * luego, tambien se agrega en una lista perteneciente al archivo de los estados
 * de este bloc, el historial de todos los puntos de navegacion por los que esta
 * pasando el cliente.
 * 
 * Lineas 28 a la 31: Se crea la funcion tipo futuro "getCurrentPosition", la
 * cual, va a obtener la posicion de la persona gracias al metodo del geolocator
 * "getCurrentPosition", y, su valor se agregará a la variable "newLocation" que
 * como se vio arriba, dará el valor a la otra variable "lastKnowLocation".
 * 
 * Lineas 33 a la 41: Se crea la funcion "startFollowingUser" que, gracias a la
 * primera linea de codigo de la misma, se ejecuta al empezar la ejecucion del
 * programa. Se crea el flujo para el seguimiento del cliente y se almacena
 * la posicion de acuerdo al flujo ya creado. Esta posicion tambien va en "newLocation"
 * 
 * Lineas 43 a la 47: Se crea la funcion "stopFollowingUser" que va a cancelar el
 * flujo con base a la variable declarada al principio de la clase padre, y 
 * agregar este resultado en la otra clase "OnStopFollowingUser".
 * 
 * Lineas 50 a la 53: Se crea la funcion "close" que es una funcion integrada
 * dentro de los flujos, ahi se ejecuta la funcion anteriormente vista, cerrando
 * el flujo definitivamente.
 * 
 */