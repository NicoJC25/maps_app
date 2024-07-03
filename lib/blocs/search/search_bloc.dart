import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnDeactivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    // Decodificar
    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = points
        .map((coor) => LatLng(coor[0].toDouble(), coor[1].toDouble()))
        .toList();

    return RouteDestination(
        points: latLngList, duration: duration, distance: distance);
  }
}


//EXPLICACION DE TODO EL CODIGO
/**
 * 
 * Lineas 11 a la 19: En la clase principal, se crea una variable que va a tener
 * lo relacionado al servicio de trafico. Luego, en el constructor, se adjuntan
 * 2 eventos, uno cuando se active el marcador manual y otro cuando se desactive,
 * poniendo en true o false el respectivo booleano de mostrar el display.
 * 
 * Se crea una funcion tipo Future "getCoorsStartToEnd", que será de tipo
 * "RouteDestination", un modelo creado apra traer las 3 caracteristicas que se
 * van a usar, por lo cual, va a retornar los valores que necesita ese modelo.
 * 
 * Primero, se define una variable que va a ser la respuesta de la traida de las
 * coordenadas marcadas en el mapa. Al obtener estas coordenadas, se van a sacar
 * la encriptacion tipo "geometry" de las coordenadas, la duracion de tiempo
 * del punto A al punto B, y la distancia. Luego, se va a decodificar los
 * puntos del "geometry" como se ve en la linea 29. El "accuracyExponent" es 6
 * debido a que esa es la cantidad de exponentes que usa MapBox en sus coordenadas.
 * 
 * Se crea una variable que va a mapear la lista anterior ya que, esa lista,
 * tiene valores de numeros y se necesitan valores de longitud y latitud. Entonces,
 * por cada coordenada, se va a crear un objeto tipo "LatLng" y al final, se va
 * a convertir en lista el map.
 * 
 * Por ultimo, se mandan las variable al modelo de "RouteDestination"
 */