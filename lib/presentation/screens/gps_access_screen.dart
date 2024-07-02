import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
        return !state.isGpsEnabled
            ? const _EnableGpsMessage()
            : const _AccessButton();
      })),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso al GPS'),
        MaterialButton(
            color: Colors.black,
            shape: const StadiumBorder(),
            elevation: 0,
            onPressed: () {
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGpsAccess();
            },
            child: const Text(
              'Solicitar Acceso',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Debe de habilitar el GPS',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
      ),
    );
  }
}


//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Linea 12 a la 15: Se utiliza un "blocbuilder" para crear una instancia del bloc y 
 * poder usarlo sin problemas, se pasa un bloc de origen que en este caso es
 * "GpsBloc", el cual viene del archivo "gps_bloc.dart" (Explicacion de ese archivo
 * dentro del mismo), y un estado que viene del archivo "gps_state.dart". Se
 * pasa un contexto y un estado, que son los dos nombrados anteriormente.
 * 
 * Luego, se hace un condicional que indica que si la el estado del gps es false
 * o desactivado, se ejecute una clase que se vera en un momento respecto a
 * solicitar activar el gps, y luego, si ya está activado, se ejecutará la
 * clase para pedir acceso a la ubicacion.
 * 
 * Lineas 21 a la 45: Se crea una clase llamada "_AccessButton" que lo que hará
 * es asignar una columna de widgets donde hay un texto y un boton, el texto
 * pedirá acceso a la ubicacion y el boton ejecutará una ventana emergente
 * donde se podrá dar acceso a la ubicacion. La accion del boton se realizará
 * mediante el llamado de un proovedor del bloc por medio de la variable "gpsBloc"
 * en donde se llamará a la funcion "askGpsAccess" que tendrá explicacion en 
 * su archivo correspondiente.
 * 
 * Lineas 47 a la 59: Se crea la clase "_EnableGpsMessage", en la cual, solo se
 * mostrara un mensaje solicitando que la persona habilite el gps.
 * 
 * 
 */