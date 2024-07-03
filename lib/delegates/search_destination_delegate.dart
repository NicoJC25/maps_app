import 'package:flutter/material.dart';
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
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
            leading:
                const Icon(Icons.location_on_outlined, color: Colors.black),
            title: const Text('Colocar la ubicación manualmente',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              // TODO: regresar algo...

              final result = SearchResult(cancel: false, manual: true);
              close(context, result);
            })
      ],
    );
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Se crea un "delegate" custom. Un delegate es una adicion que se requiere para
 * los buscadores. Estos delegates aportan las funcionalidades de las sugerencias
 * cuando se busca algo, que se debe hacer al buscar, las acciones generales,
 * entre otras cosas personalizables.
 * 
 * Lineas 4 y 5: Creacion de la clase que se extiende de "SearchDelegate", en la
 * linea 5 se renombra el texto que irá como hint.
 * 
 * Lineas 7 a la 16: Se configura "BuildActions" que son acciones varias que se
 * ejecutan con el buscador. En este caso, se configura un icono que al dar click,
 * borre el texto escrito en el buscador.
 * 
 * Lineas 18 a la 27: Se configura "buildLeading" que son otras configuraciones
 * superiores del buscador. En este caso, se configura un icono que al dar click,
 * vuelva al mapa. Se utiliza la clase "SearchResult" que es una clase
 * propia en los modelos para configurar todo de manera mas intuitiva y menos
 * propensa a errores.
 * 
 * Lineas 29 a la 32: Se configura "buildResults" en donde se harán acciones
 * cuando se busque algo. En este caso, nada por ahora.
 * 
 * Lineas 34 a la 51: Se configura "buildSuggestions" que son cosas que sugiere
 * el buscador al ejecutar alguna accion. En este caso, se le indica que muestre
 * un icono junto con un texto que tendrán la funcion de que el usuario pueda
 * elegir su destino en el mapa manualmente. Se pasa una instancia del modelo
 * "SearchResult" indicando que la eleccion manual del destino, es true.
 * 
 */