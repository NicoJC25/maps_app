//import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool cancel;
  final bool? manual;
  final LatLng? position;
  final String? name;
  final String? description;

  SearchResult(
      {required this.cancel,
      this.manual = false,
      this.position,
      this.name,
      this.description});

  @override
  String toString() {
    return '{ cancel: $cancel, manual: $manual }';
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Lineas 8 a 10: Se agregan las 3 variables para hacer funcionar la busqueda
 * por lugares.
 * 
 * Lineas 12 a 17: Se agregan las variables al constructor.
 * 
 */