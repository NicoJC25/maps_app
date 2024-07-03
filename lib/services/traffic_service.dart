import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap(resp.data);

    return data;
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Este es un archivo de configuracion basica para una peticion http. Se crea
 * una variable para traer el trafico o todos los datos de la peticion, luego,
 * una variable para traer la url base que sirve si o si en todas las sitauciones.
 * 
 * Lineas 11 y 12: Se crea un constructor por asi decirlo, en el cual, se le
 * agrega el interceptador previamente explicado.
 * 
 * Lineas 14 a la 23: Se crea una funcion tipo Future "getCoorsStartToEnd" que 
 * obtendrá toda la solicitud http, configurandola de cierta manera para resumir
 * la cantidad de espacio que ocupa la misma.
 * 
 * Se define una variable que tendrá solo la parte de las coordenadas, conformada
 * por las coordenadas de comienzo y fin, que son las que se llevan a cabo
 * por todo el proceso extenso de los blocs y demas vistos previmanete.
 * 
 * Se define una variable que tendra la url final, conformada por la url base,
 * el metodo de transporte de la ruta, y las coordenadas (los headers se envian)
 * por medio del interceptor.
 * 
 * Luego, se define otra variable para asignar los interceptores a la url por
 * medio de "_dioTraffic".
 * 
 * Por ultimo, se crea otra variable para transformar los datos de esa peticion
 * en un mapa y retornarlos.
 * 
 */