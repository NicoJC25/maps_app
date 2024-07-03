import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/presentation/screens/screens.dart';
import 'package:maps_app/services/services.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
          create: (context) =>
              MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(
          create: (context) => SearchBloc(trafficService: TrafficService())),
    ],
    child: const MapsApp(),
  ));
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MapsApp',
        home: LoadingScreen());
  }
}

//Explicacion general del codigo
//Nota: Importaciones necesarias:
/**
 * 
 * bloc
 * flutter_bloc
 * equatable
 * geolocator
 * permission_handler
 * google_maps_flutter
 * google_polyline_algorithm
 * dio
 * 
 */

//Revisar primero la rama de la seccion 19 finalizada
//Orden de archivos para la explicacion (recomendable que si hay algo que no se entiende, volver a otros archivos y revisar de nuevo)
/**
 * 
 * 1. Search Bloc
 * 2. Search State
 * 3. Search Event
 * 4. Traffic Service
 * 5. Traffic Interceptor
 * 6. Search Destination Delegate
 * 7. Search Bar
 * 8. Manual Marker
 * 9. Map Screen
 * 10. Search Result
 * 11. Traffic Response
 * 12. Map View
 * 13. Main
 * 14. Show Loading Message
 * 15. Route Destination
 * 16. Map Bloc
 * 17. Map Event
 * 
 */

//EXPLICACION ARCHIVO MAIN
/**
 * 
 * Linea 15 y 16: Se agrega el nuevo bloc "search" ademas de pasarle como
 * argumento que va a recibir el servicio de trafico de las peticiones http
 * 
 */