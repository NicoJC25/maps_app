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
