import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class SearchBarMaps extends StatelessWidget {
  const SearchBarMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : FadeInDown(
                duration: const Duration(milliseconds: 300),
                child: const _SearchBarBody());
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody();

  Future<void> onSearchResults(
      BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final start = locationBloc.state.lastKnownLocation;
      if (start == null) return;

      final end = result.position;
      if (end == null) return;

      final destination = await searchBloc.getCoorsStartToEnd(start, end);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
            onTap: () async {
              final result = await showSearch(
                  context: context, delegate: SearchDestinationDelegate());
              if (result == null) return;

              onSearchResults(context, result);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
              child: const Text('¿Dónde quieres ir?',
                  style: TextStyle(color: Colors.black87)),
            )),
      ),
    );
  }
}

//EXPLICACIO DE TOO EL CODIGO:
/**
 * 
 * Lineas 31 y 32: Se agregan otros 2 blocs.
 * 
 * Lineas 39 a la 48: Se hace una validacion cuando la busqueda no sea manual
 * sino por lugares. Se trae la ubicacion de inicio como la ubicacion del
 * usuario, la ubicacion final como el valor de la variable "position", se les
 * hace sus respectivas validaciones por si se encuentran nulas, y, por ultimo,
 * se ejecuta la clase que se encarga de construir la polyline en el mapa.
 * 
 */