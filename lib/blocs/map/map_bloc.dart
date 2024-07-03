//Explicacion al final del codigo
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/config/themes/themes.dart';

import '../location/location_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;

      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(takunaMapTheme));

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocation);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 17 y 20: Se define una variable que va a tomar el "locationBloc" ya
 * que sera necesario para el futuro y la otra linea, define una variable para
 * cerrar el flujo de una funcion que se verá mas adelante.
 * 
 * Lineas 24 a la 29: Se inicializan varios eventos. El primero será "OnStartFollowingUserEvent"
 * que se ejecutará cuando inicie la app, para seguir al usuario automaticamente
 * en todo momento, por medio de una funcion privada que se verá mas adelante. 
 * El siguiente será "OnStopFollowingUserEvent", que ejecutará un evento que indica
 * que el parametro de seguir al usuario estará en falso. El siguiente evento es
 * "UpdateUserPolylineEvent" que va a traer otra funcion que se verá mas adelante.
 * Por ultimo, "OnToggleUserRoute" que cambiará el estado de la variable "showMyRoute"
 * 
 * Lineas 31 a la 40: La variable que cerrará el flujo del "locationbloc" va a tomar
 * el mismo flujo como valor, ya que asi lo podrá cerrar despues. Primero, se
 * valida si hay un ultimo estado de localizacion actual registrado, si lo hay,
 * entonces se enviará la ubicacion actual del usuario como una "polyline" que esto
 * se explicará mas adelante, pero es una linea que traza una ubicacion, en este
 * caso, va a trazar una linea por todos los lados donde el usuario ha estado 
 * caminando.
 * 
 * Luego, se hace otra validacion de si se esta haciendo seguimiento al usuario,
 * en caso de que no, que retorne nada. Y una ultima validacion de si se sabe
 * la ubicacion actual del usuario, en caso de que no, tambien que retorne nada
 * y reinicie todos los procesos. Estas validaciones son necesarias para saber
 * en que estado se tiene la aplicacion, dependiendo de este, se pueden ejecutar
 * las otras acciones o no, y con eso no se ejecutan acciones que puedan sacar
 * errores.
 * 
 * Lineas 50 a la 56: Se crea la funcion privada "_onStartFollowingUser" que va
 * a inicializar un evento donde se indique que la variable booleana 
 * "isFollowingUser" está en true, adicional, se indica que si se conoce la
 * ubicacion actual del usuario, redireccione la camara automaticamente a el,
 * accion que se ejecuta cada que se registra una nueva ubicacion del usuario.
 * 
 * Lineas 58 a la 72: Se crea la funcion privda "_onPolylineNewPoint" que va a
 * inicializar un evento, dentro de el, se va a establecer la polyline que
 * se msotrará mientras el usuario se mueva. Se configura dentro una id automatica,
 * sus caracteristicas visuales y los puntos, que seran en este caso la variable
 * "userLocation" de los eventos que ya vendrá con el valor de la posicion del
 * usuario. Finalmente, se hace un Map que va a tener todas las polylines de
 * la linea, estableciendo que cada valor del Map, será la polyline establecida
 * anteriormente por singular. Ya por ultimo, se emite ese Map a la variable
 * "polylines" que es la que almacena todas las polylines generales afuera
 * del bloc.
 * 
 * Lineas 79 a la 83: Se cierra el flujo del "locationBloc" por medio de la
 * funcion "close()"
 * 
 */