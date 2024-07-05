//Explicacion al final del codigo
import 'dart:async';
//import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/config/helpers/helpers.dart';
//import 'package:maps_app/config/themes/themes.dart';
import 'package:maps_app/models/models.dart';

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

    on<DisplayPolylinesEvent>((event, emit) => emit(
        state.copyWith(polylines: event.polylines, markers: event.markers)));

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
    //_mapController!.setMapStyle(jsonEncode(takunaMapTheme));

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

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    // Custom Markers
    //final customStartMarker = await getAssetImageMarker();
    //final customEndMarker = await getNetworkImageMarker();

    final customStartMarker =
        await getStartCustomMarker(tripDuration, 'Mi ubicación');
    final customEndMarker =
        await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    final startMarker = Marker(
      //anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: customStartMarker,
      // infoWindow: InfoWindow(
      //   title: 'Inicio',
      //   snippet: 'Kms: $kms, duration: $tripDuration',
      // )
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: customEndMarker,
      // anchor: const Offset(0,0),
      // infoWindow: InfoWindow(
      //   title: destination.endPlace.text,
      //   snippet: destination.endPlace.placeName,
      // )
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));

    //await Future.delayed(const Duration(milliseconds: 300));

    //_mapController?.showMarkerInfoWindow(const MarkerId('start'));
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

//EXPLICACION DE CAMBIOS EN EL CODIGO:
/**
 * 
 * Lineas 3, 9 y 10: Se comentan las lineas para el estilo del mapa ya que se
 * encontró el metodo que no está deprecado aplicado en el archivo "map_view".
 * 
 * Lineas 34 y 35: Se agregan los marcadores como parte dek evento que crea las
 * polylines.
 * 
 * Linea 51: Se comenta el metodo deprecado.
 * 
 * Lineas 90 a 94: Adaptacion de la cantidad de distancia en el recorrido adaptado
 * a kilometros, y del tiempo adaptado a minutos.
 * 
 * Lineas 96, 97 y 98: Otro metodo de agregar marcadores personalizados, en este
 * caso, se llaman a 2 funciones que convierte un marcador traido de los assets
 * y otro de una imagen de google.
 * 
 * Lineas 100 a 103: Se crean las 2 variables que traen los estilos de los 
 * marcadores en uso, los cuales vienen de la adaptacion realizada en los helpers.
 * 
 * Lineas 105 a 125: Se crean los 2 graficadores de los marcadores, uno al empezar
 * la ruta y otro al finalizarla. Las lineas de codigo comentadas en ambos
 * marcadores son otra formas mas de usarlos, en ese caso, los "InfoWindow" que
 * es informacion que se puede agregar a un marcador tambien. El problema es que,
 * solo se activan al dar tap en alguno de los marcadores y eso puede resultar
 * poco intuitivo para el usuario.
 * 
 * Lineas 130 a 134: Se agregan los marcadores al evento en un Map, y se mandan.
 * 
 * Lineas 136 y 138: Configuraciones adicionales para los "InfoWindow" comentados
 * anteriormente.
 * 
 */