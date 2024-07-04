import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accesToken =
      'pk.eyJ1Ijoibmljb2pjMjUiLCJhIjoiY2x5NG00ZWNxMDFsMTJpcTR2ZGlmdXRtayJ9._rnTCH4q32J4iLpJls9LAw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'country': 'co',
      'limit': 7,
      'language': 'es',
      'access_token': accesToken
    });

    super.onRequest(options, handler);
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Al igual que el archivo "traffic_interceptor", este archivo se encarga de enviar
 * los headers respectivos a la peticion HTTP de los lugares.  
 * 
 */