import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;
    searchBloc.getPlacesByQuery(proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
            itemBuilder: (context, i) {
              final place = places[i];
              return ListTile(
                title: Text(place.text),
                subtitle: Text(place.placeName),
                leading: const Icon(
                  Icons.place_outlined,
                  color: Colors.black,
                ),
                onTap: () {
                  final result = SearchResult(
                      cancel: false,
                      manual: false,
                      position: LatLng(place.center[1], place.center[0]),
                      name: place.text,
                      description: place.placeName);

                  searchBloc.add(AddToHistoryEvent(place));
                  close(context, result);
                },
              );
            },
            separatorBuilder: (context, i) => const Divider(),
            itemCount: places.length);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final history = searchBloc.state.history;

    return ListView(
      children: [
        ListTile(
            leading:
                const Icon(Icons.location_on_outlined, color: Colors.black),
            title: const Text('Colocar la ubicación manualmente',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              final result = SearchResult(cancel: false, manual: true);
              close(context, result);
            }),
        ...history.map((place) => ListTile(
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon(
                Icons.history,
                color: Colors.black,
              ),
              onTap: () {
                final result = SearchResult(
                    cancel: false,
                    manual: false,
                    position: LatLng(place.center[1], place.center[0]),
                    name: place.text,
                    description: place.placeName);

                close(context, result);
              },
            )),
      ],
    );
  }
}

/*class _CustomSearchResult extends StatelessWidget {
  final bool cancel;
  final bool manual;
  final LatLng position;
  final String name;
  final String description;

  const _CustomSearchResult(
      {required this.position, required this.name, required this.description})
      : cancel = false,
        manual = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SearchResult(
      cancel: cancel,
      manual: manual,
    ));
  }
}*/


//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 34 a la 68: Configuracion del "buildResults" que serían los resultados
 * al buscar algo.
 * 
 * Primero, se definen 2 variables:
 *  -searchBloc: Trae el bloc de busqueda
 *  -proximity: Se establece de acuerdo a la posicion actual de la persona
 * 
 * Luego, se trae "getPlacesByQuery" para enviar la proximidad y el query
 * que ya viene con la peticion.
 * 
 * Lineas 39 a la 51: Se crea un builder del bloc "search", esto con el objetivo
 * de traer mas de 1 cosa del bloc. Primero se traen los lugares en la variable
 * "places", luego, se crea una "ListView" con la propiedad "separated" (esto
 * ya depende del gusto del programador y la funcionalidad), se utiliza un
 * "itemBuilder" para luego traer cada lugar por singular, luego se configura
 * un "ListTitle" que es cada elemento que se mostrará en el buscador por singular,
 * se establece el nombre a mostrar, el subtitulo y el icono.
 * 
 * Lineas 52 a la 61: Ya es la funcion que se hará al dar tap en cualquier
 * ubicacion: Se crea un objeto tipo "SearchResult" perteneciente a uno de los
 * modelos. Se manda la informacion correspondiente y, especialmente la posicion,
 * se manda en reversa ya que MapBox maneja longitud y latitud, mientras que
 * google maps latitud y longitud, asi que para que mapbox funcione bien,
 * necesita las coordenadas al reves.
 * 
 * En la linea 60 se agrega el lugar al historial y en la 61 se cierra el proceso.
 * 
 * Lineas 65 y 66: Se configura 2 parametros del "List.separated":
 *  -separatorBuilder: El separador entre cada busqueda
 *  -itemCount: La cantidad de items a mostrar, en este caso, la longitud de
 *  la lista donde se encuentran todos los lugares que lanza la aplicacion.
 * 
 * Lineas 73 y 74: Se trae el historial
 * 
 * Lineas 87 a la 104: Con base al mapeo del historial, se hace otro "ListTitle"
 * con las mismas caracteristicas del de los resultados. Todo es igual al de
 * las busquedas exceptuando agregar el resultado al historial, ya que aqui mismo
 * estamos llamando el historial para mostrar las ultimas busquedas como
 * sugerencias.
 * 
 */