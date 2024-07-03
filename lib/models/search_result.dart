//import 'package:flutter/material.dart';

class SearchResult {
  final bool cancel;
  final bool? manual;

  SearchResult({required this.cancel, this.manual = false});

  @override
  String toString() {
    return '{ cancel: $cancel, manual: $manual }';
  }
}

//EXPLICACION DE TODO EL CODIGO:
/**
 * 
 * Este es un modelo para customizar de mejor manera algunas funciones del buscador.
 * Se tienen 2 variables: Cancel para cancelar la busqueda, y manual para activar
 * la busqueda del destino manual.
 * 
 */