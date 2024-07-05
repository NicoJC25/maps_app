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
