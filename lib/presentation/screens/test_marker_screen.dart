import 'package:flutter/material.dart';
import 'package:maps_app/presentation/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          //color: Colors.red,
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: StartMarkerPainter(minutes: 50, destination: 'Holaa'),
          ),
        ),
      ),
    );
  }
}

//EXPLICACION DEL CODIGO
/**
 * 
 * Este es un scaffold comun y corriente, el objetivo es que en el main, se
 * reemplace la pantalla que se esté mostrando en el momento por esta, para
 * ver los cambios que se van realizando y creando en los marcadores tipo widgets.
 * 
 */