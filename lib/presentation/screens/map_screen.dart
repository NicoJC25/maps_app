//Explicacion al final del codigo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
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

              return Stack(
                children: [
                  MapView(
                    initialLocation: locationState.lastKnownLocation!,
                    polylines: polylines.values.toSet(),
                  ),
                  const SearchBar(),
                  const ManualMarker(),
                ],
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
 * Lineas 44 a la 49: Se retorna un blocbuilder, en el que, se crea un map que 
 * va a traer todas las polylines de los archivos anteriores. Si el booleano
 * "showMyRoute" está en falso, entonces se va a utilizar el metodo integrado
 * "removeWhere" para remover visualmente la polyline, pero no de las lista.
 * Con esto, si el usuario quiere volver a ver la polyline, la misma se irá
 * almacenando en segundo plano y se mostrará el recorrido total.
 * 
 * Linea 56: Se indica que, las polylines del mapa, serán las que se trajeron
 * hace un momento, establecidas como un "set" ya que asi lo requiere el programa.
 * 
 * Linea 69: Se agrega el boton para mostrar u ocultar las polylines del recorrido
 * del usuario.
 * 
 */
