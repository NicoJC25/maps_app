//Explicacion al final del codigo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class BtnToggleUserRoute extends StatelessWidget {
  const BtnToggleUserRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
              icon: const Icon(Icons.more_horiz_rounded, color: Colors.black),
              onPressed: () {
                mapBloc.add(OnToggleUserRoute());
              })),
    );
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Linea 12: Se trae el bloc del mapa.
 * Lineas 14 a la 23: Se asigna las caracteristicas visuales del boton y, al presionarlo,
 * se asigna que ejecutará la funcion "OnToggleUserRoute" perteneciente al map.
 * 
 */