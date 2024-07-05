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
 * animate_do
 * 
 */

//Revisar primero la rama de la seccion 21 finalizada (se me olvido agregar comentario de orden en el main)
//Orden de archivos para la explicacion (recomendable que si hay algo que no se entiende, volver a otros archivos y revisar de nuevo)
/**
 * 
 * 1. Map Bloc
 * 2. Map event
 * 3. Map state
 * 4. Search bloc
 * 5. Start Marker
 * 6. End Marker
 * 7. Markers
 * 8. Map Screen
 * 9. Test Marker Screen
 * 10. Screens
 * 11. Places interceptor
 * 12. Traffic service
 * 13. Map View
 * 14. Places models
 * 15. Route Destination
 * 16. Custom Image Markers
 * 17. Widgets to marker
 * 18. Helpers
 * 
 */
