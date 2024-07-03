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

  void onSearchResults(BuildContext context, SearchResult result) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
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


//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 11 a la 23: Se define una clase padre que estará tambien segmentada como
 * "manual_marker" por la validacion, de que, si "displayManualMarker" esta en true,
 * no se deberia mostrar el buscador ya que es la otra pantalla, pero si está en
 * false, se muestra este buscador adicional de agregar una animacion al mismo.
 * 
 * Lineas 25 a la 35: Se crea la clase del cuerpo como tal, se utiliza una 
 * variable para traer el "searchbloc" y se indica que si se eligió la opcion
 * de elegir destino manual, se oculte el buscador.
 * 
 * Lineas 37 a la 68: Se indica que todo irá en un "safearea" para respetar los
 * espacios del dispositivo. Luego, se indica que el buscador será un contenedor.
 * Desde ahi hasta la linea 43 son configuraciones de su altura y anchura. Se
 * usa "GestureDetector" que es una funcion para saber si se esta dando click
 * o interactuando con algo, en este caso, con el contenedor.
 * 
 * Se indica que si se dio click al contenedor, muestre el "delegate" hecho de
 * forma personalizada y se ejecuta la funcion para los resultados de la busqueda.
 * 
 * De ahi para abajo, son solo configuraciones visuales para el buscador, nada mas.
 * 
 */