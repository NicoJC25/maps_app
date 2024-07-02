//Explicacion al final del codigo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView(
      {super.key, required this.initialLocation, required this.polylines});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) =>
            mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),

          // onCameraMove: ,
        ),
      ),
    );
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Linea 8: Se crea una variable para obtener la ubicacion al ejecutar el programa.
 * 
 * Lineas 14 a la 17: Se crea una variable que tenga el bloc como valor y se
 * indica que al empezar el programa, la ubicacion de la camara será donde esta
 * el cliente y el nivel del zoom.
 * 
 * Linea 19: Se define una variable que tenga las caracteristicas de la pantalla.
 * 
 * Lineas 21 a la 31: Se define una caja grande, la cual ocupara todo el ancho y
 * alto de la pantalla. Sera de tipo "GoogleMap" que es algo integrado para indicar
 * que se debe ejecutar un mapa, luego, se asigna su posicion inicial y algunas
 * caracteristicas modificables como ver o no ver la brujula, habilitar el circulo
 * azul que indica la ubicacion de uno, y, por ultimo, se ejecuta el evento de
 * iniciar el mapa.
 * 
 */