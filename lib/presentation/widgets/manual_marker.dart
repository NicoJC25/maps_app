import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/config/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 70, left: 20, child: _BtnBack()),

          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                  from: 100,
                  child: const Icon(Icons.location_on_rounded, size: 60)),
            ),
          ),

          // Boton de confirmar
          Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  minWidth: size.width - 120,
                  color: Colors.black,
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    // Todo: loading

                    final start = locationBloc.state.lastKnownLocation;
                    if (start == null) return;

                    final end = mapBloc.mapCenter;
                    if (end == null) return;

                    showLoadingMessage(context);

                    final destination =
                        await searchBloc.getCoorsStartToEnd(start, end);
                    await mapBloc.drawRoutePolyline(destination);

                    searchBloc.add(OnDeactivateManualMarkerEvent());

                    Navigator.pop(context);
                  },
                  child: const Text('Confimar destino',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                ),
              )),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack();

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            BlocProvider.of<SearchBloc>(context)
                .add(OnDeactivateManualMarkerEvent());
          },
        ),
      ),
    );
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Este archivo tiene varios widgets y funcionalidades que se mostrarán al momento
 * de usar la opcion de elegir destino manualmente.
 * 
 * Lineas 11 a la 20: Clase padre. Se crea una clase padre mas pequeña ya que,
 * al principio del programa, se hace un ternario para validar de que si el
 * booleano del "searchbloc" está en true, se muestre esta pantalla. De lo contrario,
 * que se muestre un espacio vacio, o que no se muestre nada.
 * 
 * Lineas 23 a la 30: Definicion de la clase que tendrá el cuerpo como tal y,
 * llamado de 3 blocs que se van a necesitar, ademas de una variable para traer
 * el "MediaQuery" o el responsive.
 * 
 * Lineas 32 a la 46: Se crea una "SizedBox" para encerrar todo lo que va a
 * traer este widget, osea, se cierra hasta la linea 82 esta SizedBox. Dentro,
 * primero se va a establecer que sus medidas ocuparán toda la pantalla. Despues,
 * se va a indicar que tendrá un stack para superposicion.
 * 
 * El primer widget es un icono que estará posicionado en la parte superior
 * izquierda, la configuracion del icono como tal se hace fuera para mejor
 * organizacion y se explicará mas adelante.
 * 
 * El segundo widget será otro icono que se encontrará en el centro de todo el
 * stack con el objetivo de ser el marcador de destino. Se hacen unas pequeñas
 * configuraciones para su ubicacion.
 * 
 * Lineas 49 a la 83: El tercer widget será un boton ubicado en la parte inferior
 * central de la pantalla. Se utiliza "fadeinup" como en otros widgets que tiene
 * funciones parecidas para animar estos. De ahi para abajo hasta antes del
 * "onPressed" son configuraciones visuales.
 * 
 * Dentro del "onPressed", se estableceran varias condiciones:
 *  - Si no se conoce la ubicacion actual del usuario, que no se ejecute nada.
 *  - Si no se conoce el destino, que tampoco se ejecute nada
 * 
 * Se ejecutara "showLoadingMessage" que es un mensaje de carga mientras muestra
 * la polyline de punto A - B. Abajo, se hace la declaracion final del punto A
 * y el punto B, mandando ya esto a la clase "drawRoutePolyline" que es la que
 * se encuentra en el mapbloc y dibuja la polyline. Adicional, se ejecuta la
 * funcion "OnDeactivateManualMarkerEvent" que asigna false a la parte visual
 * del marcador central y los widgets anteriormente explicados, para que no
 * salgan mas en pantalla al buscar el destino.
 * 
 * Por ultimo, se cierra el mensaje de carga de la polyline.
 * 
 * Ya en las lineas 79 a la 83, es solo el mensaje que va a mostrar el boton.
 * 
 * Lineas 90 a 110: Es la configuracion del boton que se habia declarado como
 * primer widget en este archivo. Este boton solo servira para volver atras,
 * se configura su parte visual y la funcionalidad con base a que ponga en
 * false la pantalla actual y se muestre la anterior del mapa.
 * 
 */