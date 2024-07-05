import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accesToken =
      'pk.eyJ1Ijoibmljb2pjMjUiLCJhIjoiY2x5NG00ZWNxMDFsMTJpcTR2ZGlmdXRtayJ9._rnTCH4q32J4iLpJls9LAw';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll(
        {'country': 'co', 'language': 'es', 'access_token': accesToken});

    super.onRequest(options, handler);
  }
}

//EXPLICACION DE LSO CAMBIOS REALIZADOS:
/**
 * 
 * Se agrego en la linea 10 el país para tener mejor exactitud de los lugares buscados.
 * Y adicional, se retiró el limite de busqueda ya se que agrega de manera manual
 * en el "traffic_service".
 * 
 */