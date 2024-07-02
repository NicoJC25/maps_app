//Explicacion al final del codigo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/presentation/widgets/btn_toggle_user_route.dart';
import 'package:maps_app/presentation/widgets/widgets.dart';
import 'package:maps_app/views/views.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return const Center(child: Text('Espere por favor...'));
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnLocation(),
        ],
      ),
    );
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Linea 15: Declaracion de una variable tipo late, para traer el bloc de "location"
 * 
 * Lineas 21 y 23: Se define el valor de la variable anterior como el bloc y luego,
 * se trae la posicion actual del cliente por medio de la funcion "getCurrentPosition"
 * 
 * Lineas 27 a la 30: "dispose" es una clase integrada que se ejecuta cuando el
 * stateful widget se rompe o se reinicia, asi, de esa manera, se obtiene la
 * posicion de vuelta asi se haya salido a otra pantalla.
 * 
 * Lineas 37 a la 41: Se hace una validacion de, si la ubicacion del cliente es
 * nula, si es asi, que se ponga un mensaje en pantalla de espera mientras se
 * carga el mapa.
 * 
 * Lineas 43 a la 51: "SingleChildScrollView", es un widget que asegura el deslizar
 * una pantalla asi hayan objetos superpuestos, muy util para el mapa. Dentro,
 * tendrá un stack ya que se pondrán otros objetos encima del mapa, y dentro del
 * stack, se retorna un objeto tipo "MapView", que es un widget personalizado
 * que se explicará mas adelantes, pero por ahora, se indica que la posicion
 * inicial es la posicion actual, ya que se tiene que establecer un punto de
 * aparicion al ejecutar el mapa.
 * 
 * Lineas 54 a la 57: Se establece un FAB y hasta este momento se establece
 * solo la ubicacion, las caracteristicas del boton estan en otro archivo, pero
 * el objetivo del boton es reubicar al cliente en donde esta su ubicacion actual.
 * 
 */
