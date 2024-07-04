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
