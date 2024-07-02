//Explicacion al final del codigo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/ui/ui.dart';
import '../../blocs/blocs.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.my_location_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            final userLocation = locationBloc.state.lastKnownLocation;
            if (userLocation == null) {
              final snack = CustomSnackbar(message: 'No hay ubicacion');
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
            }

            mapBloc.moveCamera(userLocation);
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