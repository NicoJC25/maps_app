//Explicacion al final del codigo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
                icon: Icon(
                    state.isFollowingUser
                        ? Icons.directions_run_rounded
                        : Icons.hail_rounded,
                    color: Colors.black),
                onPressed: () {
                  mapBloc.add(OnStartFollowingUserEvent());
                });
          },
        ),
      ),
    );
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 12 y 13: Se crean y establecen 2 variables que traen los blocs
 * location y map.
 * 
 * Lineas 14 a la 23: Caracteristicas fisicas del boton FAB.
 * 
 * Lineas 24 a la 30: Se establece la funcion al pulsar el boton, en donde se
 * crea una variable para obtener la ultima ubicacion del cliente. Se valida
 * si la ubicacion es nula, si lo es, se establece un mensaje que diga que no hay
 * ubicacion, que son las lineas 27 a la 30.
 * 
 * Linea 32: Si hay una ubicacion, se establece la camara a esa ubicacion.
 * 
 */