import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/presentation/screens/screens.dart';

import '../../blocs/gps/gps_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return state.isAllGranted ? const MapScreen() : const GpsAccessScreen();
      },
    ));
  }
}

//EXPLICACION DE TODO EL CODIGO
/**
 * 
 * Dentro del cuerpo del widget principal, se construye un bloc de acuerdo ya
 * a los valores traidos del bloc. Se valida por medio de la variable
 * "isAllGranted" traida del archivo de los eventos, si es true o false. Si
 * es true, que se envíe a otra pantalla donde iria el mapa y si es false,
 * que siga permaneciendo en la pantalla correspondiente a los permisos.
 * 
 */