import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/presentation/screens/screens.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(
          create: (context) =>
              MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      BlocProvider(create: (context) => SearchBloc()),
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
 * 
 */

//Revisar primero el otro proyecto flutter llamado "maps_app_prototype_2"
//Orden de archivos para la explicacion (recomendable que si hay algo que no se entiende, volver a otros archivos y revisar de nuevo)
/**
 * 
 * 1. Main
 * 2. Map bloc
 * 3. Map Event
 * 4. Map State
 * 5. Map Screen
 * 6. Map view
 * 7. Btn toggle user route
 * 
 */

//EXPLICACION ARCHIVO MAIN
/**
 * 
 * No hay ningun cambio
 * 
 */