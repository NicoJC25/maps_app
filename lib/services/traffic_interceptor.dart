import 'package:dio/dio.dart';

const accesToken =
    'pk.eyJ1Ijoibmljb2pjMjUiLCJhIjoiY2x5NG00ZWNxMDFsMTJpcTR2ZGlmdXRtayJ9._rnTCH4q32J4iLpJls9LAw';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accesToken
    });

    super.onRequest(options, handler);
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Este es un interceptador. Un interceptador, es una configuracion que uno puede
 * hacer por defecto de acuerdo a una peticion http, la configuracion va de la
 * mano con el header de esta peticion. Se mandan configuraciones como el token
 * de acceso, alternativas, la encriptacion geometry, entre otras. 
 * 
 */